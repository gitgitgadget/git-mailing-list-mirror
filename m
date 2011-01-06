From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: git mergetool broken when rerere active
Date: Thu, 6 Jan 2011 14:51:34 -0500
Message-ID: <AANLkTimOzwaw6VN+NPfCJPH9t0G64r=WrffNpfHQ0h-F@mail.gmail.com>
References: <alpine.DEB.1.10.1101052119530.26654@debian>
	<7vbp3tc142.fsf@alter.siamese.dyndns.org>
	<7v62u1bzeg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Magnus Baeck <magnus.back@sonyericsson.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 20:51:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pavs5-000692-AZ
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 20:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644Ab1AFTvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 14:51:36 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52539 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab1AFTvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 14:51:35 -0500
Received: by eye27 with SMTP id 27so7376944eye.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 11:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=H4EJIAGDbwnN4wNclcbX+RP6EqcX7Uv65AzdrDPr0VE=;
        b=qt/7zodLUicpFIK9lbkwJMcuv/WQW5Ay+JsXgi3VKe6h4DvtGDwr/Kh63MaErXmXP+
         gTLLWWQIDWLsu6QRQdtcW2aPLgO1/skntff+DNeXM2yeuUmPyXy+IhC11C2AJcKGhu7J
         QCICShimIv97LZdYW3OvlYBP7evcRmyU+Fm7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PLV0EzNlm4d1HbHxqRMYvSJbAVjuDfN5EFiM0Y9Wt/xTJkXVn3lH10Bm9N4N+25IB6
         b8ho7pjLAq9OItjPBU18tRzlNWJv9mbbEApF7O/SLyrYIWvJvWWiQcXvWIcSuF5OV47C
         OFdf7tGdCfufcncZXPt03/RnQZtt/5F2V6B84=
Received: by 10.213.19.84 with SMTP id z20mr753082eba.80.1294343494240; Thu,
 06 Jan 2011 11:51:34 -0800 (PST)
Received: by 10.14.124.197 with HTTP; Thu, 6 Jan 2011 11:51:34 -0800 (PST)
In-Reply-To: <7v62u1bzeg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164661>

On Thu, Jan 6, 2011 at 2:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Probably we would need a "git rerere remaining" sobcommand that is similar
>> to status but also includes the "punted" paths.
>
> ... which may look like this.

Thanks! Will have a look at this tonight when I get home.
