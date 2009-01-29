From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: Appropriateness of git for digital video production versioning
Date: Thu, 29 Jan 2009 16:48:35 +0100
Message-ID: <3af572ac0901290748g5c5b3043j425adbda8f5d7619@mail.gmail.com>
References: <8c4a72800901290736p4952e53byddca243f300dd8af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Earl <charles.cearl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 16:50:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSZ9a-00029L-Up
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 16:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbZA2Psm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 10:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbZA2Psl
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 10:48:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:5808 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbZA2Psk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 10:48:40 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1453990nfc.21
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 07:48:36 -0800 (PST)
Received: by 10.223.124.209 with SMTP id v17mr226020far.6.1233244115289; Thu, 
	29 Jan 2009 07:48:35 -0800 (PST)
In-Reply-To: <8c4a72800901290736p4952e53byddca243f300dd8af@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107697>

Hello,

Git is not the appropriate tool. What about using a filesystem with
versioning support? tux3, btrfs, ZFS and NILFS may work for you.

On Thu, Jan 29, 2009 at 4:36 PM, Charles Earl <charles.cearl@gmail.com> wrote:
> Hi,
> Are there past instances of git having been adapted to support version
> control of digital media production workflow?
> I'm evaluating CMS and versioning systems for the backend of a SaaS
> for digital media production workflow.
> The bulk of content stored is binary data -- there have been posts on
> this about integration of various binary diff implemetations with git.
> The versioning of metadata, scripts, project structure seems to argue
> for applicability of system such as git -- these fit the paradigm of
> traditional scm.
> Example content is from media production suites such as Adobe After
> Effects/Premier: video, compositions, etc.
> I'd also like the object storage to be in S3/Amazon BlockStore or
> similar remote stores.
> Charles
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
