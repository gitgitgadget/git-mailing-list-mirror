From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 15 Aug 2007 08:48:04 -0400
Message-ID: <30e4a070708150548r3234cd66yd4ee6a85989a98b1@mail.gmail.com>
References: <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de>
	 <e7bda7770708101531n782118e9qb9c6de4e934940ea@mail.gmail.com>
	 <EF7DFA5A-9C3A-4D0B-9533-D1D60AE4A44C@zib.de>
	 <e7bda7770708141704m587dfdbdqfbab51b8ac6fcff@mail.gmail.com>
	 <30FE2B1C-B651-4F1D-B5D9-CD3C3261F531@zib.de>
	 <85fy2l1i1g.fsf@lola.goethe.zz>
	 <ABA1D7D2-92A6-4E8C-AC36-93912621E3D4@zib.de>
	 <86k5rx474o.fsf@lola.quinscape.zz>
	 <20070815073811.GL27913@spearce.org>
	 <30e4a070708150542m3f3f5c62l5e4bf5b3ff098b52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Torgil Svensson" <torgil.svensson@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 15 14:48:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILIIG-0006pI-Og
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 14:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbXHOMsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 08:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753447AbXHOMsI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 08:48:08 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:49102 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbXHOMsG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 08:48:06 -0400
Received: by nz-out-0506.google.com with SMTP id s18so759355nze
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 05:48:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=spIEX7tncf50zO0b729y+3ljGNy6lIn6eTp4wOV2+8mH4TE9iV0zWCvLSppuxrRlpZyxRnQBMVMJVwvN8FkVbi3H9lKwDlOxTnKI1ZSk9vAyP2iNcm5EWUHDmkUPY9Uq59JGYdVBMy5SikgWNf7+OSo/IaB9IFnYXyjid1buw4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DdMDTKTjatfBbz6aoIs6nrnK6MR5DR8f9v+JnrTSB/xQ9SzpyI0SkeXRv0uO0hdih3DQz1lXFJt4PSMYyF3hwNn00HX83JH/31gLnpwKtvxLFTtEKnm5ncVRFynXIOhmzkcGEt2ibDkOnczw0Z57ZpCpWPRDjygk4AoZKld7C2A=
Received: by 10.142.84.3 with SMTP id h3mr20797wfb.1187182084935;
        Wed, 15 Aug 2007 05:48:04 -0700 (PDT)
Received: by 10.143.156.1 with HTTP; Wed, 15 Aug 2007 05:48:04 -0700 (PDT)
In-Reply-To: <30e4a070708150542m3f3f5c62l5e4bf5b3ff098b52@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55898>

On 8/15/07, Mark Levedahl <mlevedahl@gmail.com> wrote:
> On 8/15/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > David Kastrup <dak@gnu.org> wrote:
> > >     Load a Hive, Query, Save, Restore, and Unload a Hive. To install
> > >     the Support Tools:
> > >
> > >     1.
> > >
> > >
> > >     Insert the Windows 2000 CD-ROM into your CD-ROM drive.
> >
> > Indeed, that step right there will stop many users cold in their
> > tracks.
>
maybe something like ...

case "$(uname -s) in
   MSYS*)
       <your way>;;
   *)
       <the unix way>;;
esac

Mark
