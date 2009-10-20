From: "Richard" <richard@webdezign.co.uk>
Subject: RE: Moving git
Date: Tue, 20 Oct 2009 17:37:12 +0100
Message-ID: <8440EA2C12E50645A68C4AA9887166512446DD@SERVER.webdezign.local>
References: <25926819.post@talk.nabble.com> <alpine.LNX.2.00.0910201222080.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:37:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Hi5-0002zi-Md
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 18:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbZJTQhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 12:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbZJTQhK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 12:37:10 -0400
Received: from mail.webdezign.co.uk ([213.123.201.79]:58348 "EHLO
	webdezign.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751146AbZJTQhJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 12:37:09 -0400
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <alpine.LNX.2.00.0910201222080.14365@iabervon.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Moving git
Thread-Index: AcpRoxdjlXLmiHF9SaeDgS3zejn6bgAAEsjQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130810>

Thanks to anyone for the reply, but this issue has been resolved. I
might have submitted this several times, but Nabble keeps on nagging me
about multiple posts. So I'm just going to delete it.

-----Original Message-----
From: Daniel Barkalow [mailto:barkalow@iabervon.org] 
Sent: 20 October 2009 17:34
To: Richard
Cc: git@vger.kernel.org
Subject: Re: Moving git

On Tue, 20 Oct 2009, Richard Lee wrote:

> 
> Hi Git forum,
> 
> I've just started using git yesterday, so I'm very new. So please
excuse if
> I've done something the wrong way.
> 
> I cloned a git directory/repository? and then moved it. I'm trying to
prune
> branches and it gives
> 
> ]fatal: '/var/www/vhosts/mydomain.co.uk/b2.git': unable to chdir or
not a
> git archive
> fatal: The remote end hung up unexpectedly
> ls-remote --heads /var/www/vhosts/mydomain.co.uk/b2.git: command
returned
> error: 1
> 
> b2.git was the cloned bare thing I create following the instruction
here:
> 
> http://book.git-scm.com/4_setting_up_a_private_repository.html
> 
> Is there someway I can get git to update the git base directory?

The exact problem, I think, is that your clone has saved the original 
location of the bare repository as the default upstream repository 
location, and now it's not there. (It's a little hard to tell without
the 
command that you were running when you got the error.)

If you edit the clone's .git/config, you should see the old location in
a 
'[remote "origin"]' section. If you change this to the new location, 
everything should work. You can also do it with "git remote" somehow,
but 
I personally just edit the config file, so I don't know the details.

	-Daniel
*This .sig left intentionally blank*
