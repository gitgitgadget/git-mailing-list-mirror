From: david@lang.hm
Subject: Re: how to configure Git to treat certain type of ascii files as
 binary files
Date: Wed, 22 Oct 2008 15:13:07 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810221511590.24463@asgard.lang.hm>
References: <65d12cb10810221458j14ef0009u679cdb0f73299d7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Weiwei Shu <shuww1980@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 00:14:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kslxp-0004f3-Ix
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 00:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759069AbYJVWMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 18:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758441AbYJVWMa
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 18:12:30 -0400
Received: from mail.lang.hm ([64.81.33.126]:53621 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624AbYJVWM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 18:12:29 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m9MMCOj1030992;
	Wed, 22 Oct 2008 15:12:25 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <65d12cb10810221458j14ef0009u679cdb0f73299d7f@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98920>

On Wed, 22 Oct 2008, Weiwei Shu wrote:

> Hello everyone,
>
> My first post in this mailing list. Could some one direct me to some
> document/manual pages to setup Git to treat ascii files as binary
> files? I'm using Git to do circuit schematics (SPICE files)
> versioning. I will not do any merging or editing stuff with external
> editors. The only way to change it is to use schematic capture GUIs
> (Cadence, ADS, etc). So I'd like to treat them as binary files to
> reduce the possibilities of messing them up.
>
> I know it seems a little bit stupid to use Git to do such an easy job.
> But hey, it's the most eye-catching SCM software, isn't it?

unless you enable cr/lf handling git won't change ascii files.

what is it that you think needs to be done differently for these files 
than for any other files?

David Lang
