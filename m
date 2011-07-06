From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] svn-fe: use svn-fe --no-progress in remote-svn-alpha
Date: Wed, 6 Jul 2011 07:30:44 -0500
Message-ID: <20110706123044.GR15682@elie>
References: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
 <1309884350-13415-5-git-send-email-divanorama@gmail.com>
 <CALkWK0mrpy2bho9ExHaCSenzZLoEKSo-T0K_FVDz9VtaQcY-2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	David Barr <davidbarr@google.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 14:31:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeRFo-0003Tn-1d
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 14:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177Ab1GFMau convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 08:30:50 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64091 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab1GFMat convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 08:30:49 -0400
Received: by iyb12 with SMTP id 12so6039714iyb.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 05:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BOCK/BhpW6GAs3MUQFSFmVFk/S7aMAimxITuhlqsp/A=;
        b=cD0OGiegMe019nPs2pKhCr1BornrwKBjJ/1kjRw7SwnPut7nEH7aExqFklKdacdin7
         2pPG8jZaENrxA9/F/Rm5lTT9pCqxElXkqaHPAf4R+t0ol1fky0S9suenjwiD1sGwZAai
         DD0GbmULFOXWhVJ+LqBF4/zSMOD+w8yexuhmg=
Received: by 10.43.64.66 with SMTP id xh2mr9211764icb.391.1309955449074;
        Wed, 06 Jul 2011 05:30:49 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.ameritech.net [69.209.76.243])
        by mx.google.com with ESMTPS id y1sm8743763ica.16.2011.07.06.05.30.47
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 05:30:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mrpy2bho9ExHaCSenzZLoEKSo-T0K_FVDz9VtaQcY-2g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176700>

Ramkumar Ramachandra wrote:
> Dmitry Ivankov writes:

>> Just disable progress lines for now.
>>
>> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
>> ---
>> =C2=A0contrib/svn-fe/git-remote-svn-alpha | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> Perhaps squash this into the patch that introduces --[no]-progress in=
 svn-fe?

Since git-remote-svn-alpha is a slushy codebase and svn-fe is a little
more stable, it seems best to keep patches to the two separate for
now.  Even so, mentioning remote-svn's needs can still be a useful way
to make svn-fe changes easier to understand (which is what I think you
are getting at here); thanks for the hint.
