From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] diff: add a 'path' meta header for non-renames and 
	non-copies
Date: Tue, 4 May 2010 00:55:46 +0200
Message-ID: <m2i36ca99e91005031555x4bb2df54yb47058d9f7d5342c@mail.gmail.com>
References: <1272852221-14927-1-git-send-email-eli@cloudera.com>
	 <1272868072-12120-1-git-send-email-bert.wesarg@googlemail.com>
	 <7viq75tpaw.fsf@alter.siamese.dyndns.org>
	 <z2m36ca99e91005030037jb880e65w73efa551a53d7be6@mail.gmail.com>
	 <7v1vdtt0d7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eli Collins <eli@cloudera.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 04 00:55:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O94YL-0004BE-7q
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 00:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759538Ab0ECWzs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 May 2010 18:55:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39140 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758802Ab0ECWzr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 18:55:47 -0400
Received: by fxm10 with SMTP id 10so2653026fxm.19
        for <git@vger.kernel.org>; Mon, 03 May 2010 15:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z1+zakV5OpC/pJmHkjSK5MvfMNwDJuGGHfmPIacQG1c=;
        b=X3sgTkoBlDHZTLKGdqTux1ZUOAd2PVd0He1LvCHArQKX7yPcxQIwqrBvMaj5khBdy9
         qq8+faWgB/06SuZaWn+hNsJfbIUQRkAZ3ozVCvYteVUjzxTCycF/D+6xcs63E3mF9Eyh
         w6oc9QMYJWcGZnD9RQM2Q/AJ2mTOGyr4hjf3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WVtO48+c4jdIVbKrX3ByaVSnZZBZK8XtxkLRh7hLl6k8lmYqqJ3PTqxztm0t5ZOzOj
         FCprl1DMWpQEaHb4LStDF7Hn3h1r4dYXuzb8EYZyVSvI9OsC97WT2jPUjbBVX8JaLsUf
         5J38rsBmHZHUO7r8UDhAaQMC75ZtHcKbjkusQ=
Received: by 10.223.98.83 with SMTP id p19mr3613489fan.27.1272927346409; Mon, 
	03 May 2010 15:55:46 -0700 (PDT)
Received: by 10.223.113.146 with HTTP; Mon, 3 May 2010 15:55:46 -0700 (PDT)
In-Reply-To: <7v1vdtt0d7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146267>

On Mon, May 3, 2010 at 18:29, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> As far as I understand git_diff_ui_config() applies only for "git
>> diff" not for any of the plumping "git diff-*" tools.
>
> Ah, I missed that the patch was to the diff_ui parser. =C2=A0Sorry fo=
r
> confusion and thanks for straightening me up.
>

So, now that I render your arguments voidless, do you have any other
thoughts on adding a <path> extended header for non-renames and
non-copies?

Regards,
Bert
