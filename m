From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Adding Beyond Compare as a merge tool, was: Re: What's cooking in
 git.git (Feb 2011, #05; Wed, 23)
Date: Sun, 27 Feb 2011 12:15:50 +0100
Message-ID: <AANLkTinByZS0yQ6TNTwp74kW3yvTg8G_PQN3F99MKR2w@mail.gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
	<4D68D4FA.7090500@gmail.com>
	<4D69E355.7010104@gmail.com>
	<AANLkTimWPwCFgnAYz_jJ3Yw5QWvPNhPxq=j502UorEot@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	charles@hashpling.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 12:15:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtebU-0000cR-4j
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 12:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030Ab1B0LPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 06:15:51 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:56848 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab1B0LPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 06:15:51 -0500
Received: by qyk7 with SMTP id 7so1546825qyk.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 03:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HKVts/bxswq4ToWpG5QVr+CAL6y0JKPTchncZIsikRo=;
        b=fhIKT0ct2jRfnelPZ43uYDy0dqWCXsBhLQIFR1z5+Q1ufq5+BI+RS/bmhPY2aMmfWI
         DGp3zfXAiaRiI5NtpRsncBjTJw+3VDc6n60eV4lDlseFjJJmT7QWqIGxRJyoBdi+pE70
         AYUvyOx4hzwjrxrCUqaqXKwxEqG0uxYF7MKVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tCnSiU33dq1tvz9uvyq44VH4n5CE/0F4jWNCAHb/3yXiFuPDai8rWjCEulUH6qIeWF
         0uipBgPeVx5WNxPThRxhiFaiPY92bj11ffEK9+fMly3Z2gfoi0Efkgn+61pXBNRcMuqx
         YSqjpy596OYAt7+ALoTZ4dZ99th9mmPxU6z4M=
Received: by 10.229.185.210 with SMTP id cp18mr3145693qcb.187.1298805350530;
 Sun, 27 Feb 2011 03:15:50 -0800 (PST)
Received: by 10.229.17.73 with HTTP; Sun, 27 Feb 2011 03:15:50 -0800 (PST)
In-Reply-To: <AANLkTimWPwCFgnAYz_jJ3Yw5QWvPNhPxq=j502UorEot@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168025>

On Sun, Feb 27, 2011 at 11:57, Sebastian Schuberth <sschuberth@gmail.com> wrote:

>> with your suggestion. We should probably make use of the -title options
>> to remove ambiguity.
>
> Good idea, I'll look into this.

Given that the -title options actually replace the display of the file
name (instead of displaying the title in addition), I'd prefer not to
make use of these options. In fact, the file names Git uses for
merging already contain "BASE", "LOCAL", "REMOTE", so there should be
no real need for additional titles, IMHO.

I'll push out the updated series now.

-- 
Sebastian Schuberth
