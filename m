From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/6] Fix '&&' chaining in tests
Date: Fri, 9 Dec 2011 10:53:01 +0530
Message-ID: <CALkWK0m3XtrU_mZ7MTGpo-MZ8s6mW1HR3WwJd_btaV6HRvZV8A@mail.gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com> <7vzkf2hm94.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 06:23:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYsvg-0007Pz-LL
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 06:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850Ab1LIFXY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 00:23:24 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33296 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab1LIFXX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 00:23:23 -0500
Received: by wgbdr13 with SMTP id dr13so4911979wgb.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 21:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Jc0VmEcnfzfVh2Ny2VRRMvyJXo+ywqQyJksHb1qhYM0=;
        b=hNhOt++KeoBY2tsp5Ox2HKlQ99xymlQg7PHbC3ssh2qjarskFkujJeiDUhrY5g0ARB
         dk8eSVf8KiC/lxUIdqQcsrGvvKriZb8JbkrQrIbAOVCFwxDXwbb8U7JIlXtmXwlhJnzR
         5mAoGNXeYwXTGodGHMBXBAAak2DsTr1qAaZd4=
Received: by 10.180.90.6 with SMTP id bs6mr8927432wib.63.1323408202229; Thu,
 08 Dec 2011 21:23:22 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Thu, 8 Dec 2011 21:23:01 -0800 (PST)
In-Reply-To: <7vzkf2hm94.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186608>

Hi,

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> This follows-up $gmane/186481.
>
> I take that you meant "replaces". =C2=A0It was confusing especially b=
ecause you
> seem to have included a few unrelated patches in the thread.

Yeah.  Sorry- stray files were lying around from the previous 'git
format-patch' invocation.  Which brings me to: I wonder if it makes
sense to (optionally) check that the directory is empty when executing
'git format-patch -o <dir>'.  I sometimes forget to do it by hand.

-- Ram
