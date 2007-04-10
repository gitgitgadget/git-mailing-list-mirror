From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: cogito selftests failures with git 1.5.1
Date: Tue, 10 Apr 2007 12:39:27 +0200
Message-ID: <8aa486160704100339w76608a73md10b2da0fcee7e8f@mail.gmail.com>
References: <20070410101626.10047.qmail@0be9eada36064d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 13:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbDlC-0003G0-9G
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 12:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbXDJKjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 06:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbXDJKjf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 06:39:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:54319 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbXDJKje (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 06:39:34 -0400
Received: by wr-out-0506.google.com with SMTP id 71so1140917wri
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 03:39:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=asPS+TUfAqZRz3u10qX7rkQEw+VNHx8Wm0y76dhvmKKcWvaI1BhE/+Xaa1cXeEzgE4PxVn3hFLTodzZyMzSKrAOmVtvPLu7ILEQRXAlZlFnnjDHf6m2mhUZoukokfBJdtf00OGmku4GcgHzqQS5yn/wVuVpnsGoim6VvB/BeCZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FJJqKO00wzQeUDuUpmMFmsQtgalglXBKK+6SQCtXkqK4ZoC1GX8/JA6Mb+IaKzZSrVRGpLgvlLOmJ9lF+eFOA7TjmUOWb2yw140V5XpgiEJ9iC4MYeHiOnLzRlieBlDAgGIOTAiEOMsIJupCLDDZdhooD/jTRSRdDHziqZxbvB8=
Received: by 10.78.203.13 with SMTP id a13mr1017227hug.1176201572315;
        Tue, 10 Apr 2007 03:39:32 -0700 (PDT)
Received: by 10.78.131.7 with HTTP; Tue, 10 Apr 2007 03:39:27 -0700 (PDT)
In-Reply-To: <20070410101626.10047.qmail@0be9eada36064d.315fe32.mid.smarden.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44120>

On 4/10/07, Gerrit Pape <pape@smarden.org> wrote:
> Hi, while cogito 0.18.2 builds and selftests fine with git 1.4.4.4, the
> following selftests fail with 1.5.1 on Debian: t9105-fetch-local.sh:20,
> t9204-merge-weird-conflicts.sh:8,20.
>
> Is there still work done on cogito?

They are already fixed in the master branch. At least the t9105 was a
fix in the test suite.

Santi
