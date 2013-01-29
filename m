From: Bryan Turner <bturner@atlassian.com>
Subject: Re: [PATCH] The images from picon and gravatar are always used over
 http://, and browsers give mixed contents warning when gitweb is served over https://.
Date: Tue, 29 Jan 2013 14:28:02 +1100
Message-ID: <CAGyf7-GJkKDWdykq8iv90tU3TUR5ZKUf2bQc9sJokbq-RFYBYg@mail.gmail.com>
References: <1359416492-8597-1-git-send-email-admin@andrej-andb.ru>
	<7vtxq0u1v3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 04:28:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U01s3-0007lp-Ge
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 04:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264Ab3A2D2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 22:28:05 -0500
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:40110 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752200Ab3A2D2E (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 22:28:04 -0500
Received: from mail-ob0-f199.google.com ([209.85.214.199]) (using TLSv1) by na3sys009aob102.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUQdBwufTbl3DhS7pGRgoT6sJP6C3we6n@postini.com; Mon, 28 Jan 2013 19:28:04 PST
Received: by mail-ob0-f199.google.com with SMTP id wd20so13768715obb.6
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 19:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:x-received:in-reply-to:references:date
         :message-id:subject:from:to:content-type:x-gm-message-state;
        bh=88FbocgATousKJRXhcv1DBpD+XqnfFXzgaJ41Sq9/dM=;
        b=Qw+SUySkjnZ5FBrYEuL0a/ANRTyayvqaTlEkwUiZgWOdTVAYwdyJX6SYJdWzxBPRAy
         w46Mrh+o7NuIdqzAs37yezQbsXUNUjZSLUqiKt9xQwyBKjmuM1QW80UqkapoCRnkphsg
         eSim5YP298lrLoib9AreFUtUGugadqmJgKYuaKoyLb51yvyn/OPiJwE5DvsK+T9qWYn/
         q8RvhmchJe5/MkgN8iVrFNG631i7l+QAULHVJTpuwgJWheTBbK3hj8eqDoadu40rfBDx
         xQKMLUO4MXVYhVuJ5wXzm/llnwcaCzlz5fV7o/tRkOp2zWyFihJwgtQTnyxfP2oapY5D
         cXlg==
X-Received: by 10.60.27.161 with SMTP id u1mr70914oeg.1.1359430082496;
        Mon, 28 Jan 2013 19:28:02 -0800 (PST)
X-Received: by 10.60.27.161 with SMTP id u1mr70912oeg.1.1359430082410; Mon, 28
 Jan 2013 19:28:02 -0800 (PST)
Received: by 10.182.232.101 with HTTP; Mon, 28 Jan 2013 19:28:02 -0800 (PST)
In-Reply-To: <7vtxq0u1v3.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQl9nxSQh0vMQCedlNBB4oqQlknWJt9hNgk1FiOLhutaGkHkTx4dzGovTcBmlkx4o2Bu5pkA0Rbgk1Y1kvTq62J1KR3jVgf8ew1vkPtgb1QPB/rlohQ43JiZrTYd4/F0CD2WAPJKuNSg3ipxIX4yTiXd40hL6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214896>

This won't work correctly as-is. The secure URL for Gravatar is
"https://secure.gravatar.com"[1], not "https://www.gravatar.com".

[1] See the "Secure Requests" section on:
https://en.gravatar.com/site/implement/images/

On 29 January 2013 14:03, Junio C Hamano <gitster@pobox.com> wrote:
>
> Thanks; will queue.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
