From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 4/4] Remove the applied/unapplied commands
Date: Sun, 13 Jul 2008 12:31:20 +0100
Message-ID: <b0943d9e0807130431q58a74e95j53458d502c3e7a0a@mail.gmail.com>
References: <20080619214023.27794.97039.stgit@localhost.localdomain>
	 <20080619214233.27794.98487.stgit@localhost.localdomain>
	 <20080622161341.GD4468@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 13:32:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHzoT-0003jN-Fv
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 13:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbYGMLbW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2008 07:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbYGMLbW
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 07:31:22 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:10102 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbYGMLbW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jul 2008 07:31:22 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2646365waf.23
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 04:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SodWLUwFYemSTK4BOnhfHDVEwN7d+e31a5GJ/gqNlLA=;
        b=Fb3jJZSZmhx9d2dcp3101Fp6z74zNYpeKg4Puw4C9nou0Ig58EDDM5kCSPdbkgZeNo
         1aQx2UcwqXUYStDji0b1XuJUbexaPo+2BqblhAEcisdW0y/uc0X0D20INCiYFRamLoFM
         ZQZOUKiFbkvGQfWL6OHe4W6QZiUfIc+xKQxVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MCWU5RzPVawzUC/7sZLP4v+ejA7hMy/HbEbRoK/eP/doVJFoaPVM2oSw04Fy4xTEnm
         OHRbJAqqCRefK7DNvsAohiYGdTR2MbrPuzZ4D+BzWQdOPBC3WueNfZWhlLXrrtNNIAj3
         bYtjky9Rap1pmujkZfrvzjz2ozw9AUbRZ8R6U=
Received: by 10.114.200.2 with SMTP id x2mr16384780waf.79.1215948680906;
        Sun, 13 Jul 2008 04:31:20 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Sun, 13 Jul 2008 04:31:20 -0700 (PDT)
In-Reply-To: <20080622161341.GD4468@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88299>

2008/6/22 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-19 22:42:33 +0100, Catalin Marinas wrote:
>
>> This patch moves the applied/unapplied functionality to the 'series'
>> command via the corresponding options.
[...]
>>             make_option('-a', '--all',
>>                         help =3D 'show all patches, including the hi=
dden ones',
>>                         action =3D 'store_true'),
>> +           make_option('--applied',
>> +                       help =3D 'show the applied patches only',
>> +                       action =3D 'store_true'),
>> +           make_option('--unapplied',
>> +                       help =3D 'show the unapplied patches only',
>> +                       action =3D 'store_true'),
>>             make_option('--hidden',
>>                         help =3D 'show the hidden patches only',
>>                         action =3D 'store_true'),
>
> Maybe some logic to prohibit the use of more than one of these at
> once? The current logic is kind of arbitrary.

I decided to allow a combination of applied/unapplied/hidden but not
together with all. I'll post the patches again.

--=20
Catalin
