From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Import ClearCaase with history?
Date: Wed, 31 Mar 2010 12:09:08 -0400
Message-ID: <o2w32541b131003310909p6558be4dxaaf0b277b149c82b@mail.gmail.com>
References: <1270035189.2785.11.camel@chumley> <20100331153905.GA14999@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Hagood <david.hagood@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 31 18:09:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx0U4-0002vd-MW
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 18:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451Ab0CaQJb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 12:09:31 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:35782 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757433Ab0CaQJa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Mar 2010 12:09:30 -0400
Received: by yxe37 with SMTP id 37so176309yxe.21
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=TTx+fRaKf/FmfOsA8TQ9xXtBXdllMcmzu4xaUPZwpO0=;
        b=Kqf7Anea9/aLXLbzDC9Ejv4TH6E6Xa3scfkP7nU79o+A8DF5dVu7KE0FKdXliYZNLo
         Wfqaywqx0gWMUFRQOdPS0JROLrWgyBILDwow2MjrOpFBtVog0/R8rSMZOhCf3nx3slEf
         Vucl1KKkdPuPgHiZZONAdGr4xz32eeM7xl580=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DRIiP/at3RnhoF5ZRo3zEHVZd+Lu8qMHuTyoCD2IMzZYOsH0sBsv5ln9hT/omYsvAZ
         cbtGA0UOe3hTp6nUWKlOQe92hPUYx+Zki/Xsi6jsCOSpzpl5Z+D/9zIkCTcr+lscJ+wi
         J0ACIrzIXGZFDYzlItIXw7UnLjCoxstWzA7NQ=
Received: by 10.150.203.4 with HTTP; Wed, 31 Mar 2010 09:09:08 -0700 (PDT)
In-Reply-To: <20100331153905.GA14999@m62s10.vlinux.de>
Received: by 10.150.239.3 with SMTP id m3mr100379ybh.69.1270051768603; Wed, 31 
	Mar 2010 09:09:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143682>

On Wed, Mar 31, 2010 at 11:39 AM, Peter Baumann <waste.manager@gmx.de> =
wrote:
> On Wed, Mar 31, 2010 at 06:33:09AM -0500, David Hagood wrote:
> The problems where no bidirectional mapping exists are the following:
>
> =A0- CC is file based, where as GIT is tree (the whole repository) ba=
sed
>
> =A0- This leads to problems where you merge a file on differen CC bra=
nches,
> =A0 =A0because in GIT a merge is only on the whole tree, so at least =
this
> =A0 =A0information is lost. (see cleartool lstree for a file with mer=
ges)

Of course, you can do such file-by-file merges in CVS and SVN as well,
and importing into git seems to work okay.  What doesn't get tracked
is the actual merge history of the merged files.  This isn't such a
problem when importing CVS and SVN, which mostly don't track merge
history anyway :)

Have fun,

Avery
