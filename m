From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: error commiting in Git
Date: Sat, 31 Jul 2010 17:33:56 -0500
Message-ID: <20100731223356.GB7490@burratino>
References: <AANLkTimOZr8zq8uXdrzrpLMTDQqwJkZEyxB_zcWFEYBs@mail.gmail.com>
 <AANLkTimqWF7gZHAXFOmz0URdDTF=CfMmjJrBwmFavUkK@mail.gmail.com>
 <AANLkTi=n-J5rMOz0pkcxQZ7VgGs_EtXpotO=wZoDyz=C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel =?iso-8859-1?Q?Fran=E7a?= <daniel.franca@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 01 00:35:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfKeS-0000R8-KO
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 00:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043Ab0GaWfK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 18:35:10 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50154 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab0GaWfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 18:35:09 -0400
Received: by gxk23 with SMTP id 23so976658gxk.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 15:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=j38erGNGSok5Buc6E6QpPHzs5LmVeDUqlcUyoXdelDU=;
        b=ZR02qLAKeKiejs07XIL0xYOe8jVxF78k0B2iUYirpNyf6oVBgSTE69+jlOvXUIFDc3
         M2KaL70i+LYu6nmo0Up0HiwHFhN+P8wGedSotDOvlypU3ernSlDacUS08ajIjcZReq7r
         PEDaWzhcp2EuU+9PEmEN41RYhL8KBB+Mcgsi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=BQSXOzmaG9pu2Qb9Fq1TD7EEWqFuQ+2Nq/f47p3rGJdiw1qaoMmJDsO8Q40URLrHca
         9xyD2Ohc8z/REt/JLG/ae7lHhacyf053yzjwp2rKMprqEac3JRwGZLxy/HOSBsAP22z5
         PzeWyBkVO+7QpaU9NZE3yiM2rikGLG67/NMRw=
Received: by 10.150.69.30 with SMTP id r30mr5292287yba.43.1280615708378;
        Sat, 31 Jul 2010 15:35:08 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e7sm2371402ybe.4.2010.07.31.15.35.06
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 15:35:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=n-J5rMOz0pkcxQZ7VgGs_EtXpotO=wZoDyz=C@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152342>

Hi Daniel,

Daniel Fran=C3=A7a wrote:

> now when I try to commito some file of my git project I get the
> following error:
> find: illegal option -- n
> find: illegal option -- a
> find: illegal option -- m
> find: illegal option -- e

Could you give the git version you use, the command you ran, and the
exact response?  =E2=80=9Cgit commit=E2=80=9D is not a shell script and=
 does not run
find, so it is hard to guess what is going on from the extract you
gave.

Jonathan
