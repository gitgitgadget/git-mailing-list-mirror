From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] branch: colour upstream branches
Date: Mon, 15 Apr 2013 22:16:44 +1000
Message-ID: <CACsJy8A9ii475i98n39HFMjRqBRHnoywn03k03qcbesJYbGUGA@mail.gmail.com>
References: <1365993469-6874-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 14:17:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URiLX-0008R9-RM
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 14:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547Ab3DOMRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 08:17:16 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:34609 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab3DOMRP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 08:17:15 -0400
Received: by mail-oa0-f52.google.com with SMTP id k18so2457501oag.11
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=o4+bG4GTkVqBXkf4cqToBYJeoYsy27MV3n1bk42Em/k=;
        b=CwlDbfUPd3te7KtnluUHQy02rPyo4EeZSS1iSjClx4fsVgVz7HKRDd4HONnu5Pza74
         /Gjmso+4aXvRZtseg6Yzc2bVnvXM5EPp123NnetY2auXXDevhw2ZtNFBIWRP6y+bdDdm
         +g+RiPqYSy+hREtwSbj3T2K4BWjk4og7JYnu4BcxZCBHUwg+ot0x6QWb7ZfV1jXptTz8
         QLbxPH/OqnKcx2qJ6k6fQHXo6qjaH2BGLlBSbzppc3g1aXoaWRfkZekAoJlUjOht8ULh
         BFeuhHf/lxEl/jmFxXbRxIZmTDWthE5XHX64DzW332feTsnV6QB0SGH0rJnaeL3uGgIw
         PkcA==
X-Received: by 10.182.103.225 with SMTP id fz1mr7474158obb.53.1366028234902;
 Mon, 15 Apr 2013 05:17:14 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Mon, 15 Apr 2013 05:16:44 -0700 (PDT)
In-Reply-To: <1365993469-6874-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221225>

On Mon, Apr 15, 2013 at 12:37 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> @@ -417,36 +421,54 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
>         int ours, theirs;
>         char *ref = NULL;
>         struct branch *branch = branch_get(branch_name);
> +       struct strbuf fancy;
> +
> +       strbuf_init(&fancy, 0);

Nitpick. You could have done "struct strbuf fancy = STRBUF_INIT;". No
need to resend, I think, unless there are other changes.
--
Duy
