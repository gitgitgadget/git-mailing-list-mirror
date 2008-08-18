From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: Re: SeLinux integration
Date: Mon, 18 Aug 2008 10:29:47 -0400
Message-ID: <1219069787.2609.86.camel@moss-terrapins.epoch.ncsc.mil>
References: <6341D084-1A83-4C0F-8C45-943916612D48@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Neuhalfen <JensNeuhalfen@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 18 16:48:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV625-0006g1-00
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 16:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbYHROr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 10:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbYHROr3
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 10:47:29 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:52063 "EHLO mummy.ncsc.mil"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752760AbYHROr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 10:47:28 -0400
Received: from facesaver.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7IElKAq012423;
	Mon, 18 Aug 2008 14:47:20 GMT
Received: from [144.51.25.2] (moss-terrapins [144.51.25.2])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7IElJCI028991;
	Mon, 18 Aug 2008 10:47:19 -0400
In-Reply-To: <6341D084-1A83-4C0F-8C45-943916612D48@gmx.de>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
X-Spam-Status: No, score=-103.8 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00,
	USER_IN_WHITELIST autolearn=ham version=3.1.8
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on
	facesaver.epoch.ncsc.mil
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92710>

On Sun, 2008-08-17 at 12:44 +0200, Jens Neuhalfen wrote:
> Hi,
> 
> I  wrote an SeLinux policy and an init.d script  for the git-daemon  
> and now seek for comments and improvements.
> 
> The scripts were tested on my Centos 5.2 box  and an older version had  
> been tested on FC 9.
> 
>   Features:
>     * multiple configuration files for the init.d script
>     * selinux support for git daemon
>     * seboolean (git_daemon_update_repository) that forces git-daemon  
> into strict read-only mode when set to false
> 
> TODO
>   * The policy and the accompanying init.d script still lack  
> documentation
>   * see selinux/BUGS and initd/BUGS
> 
> Feel free to pull from my repository and comment. If the everything is  
> 'good' I will send patches to the list, so that SeLinux support can be  
> integrated into the main repository.
> 
> 
>   git://www.neuhalfen.name/git-selinux.git
> 
> 
> Jens
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hello,
   It is great to see people other than the core policy developers
working on SELinux policy. One thing I would suggest is to post your
policy to the new reference policy mailing list for SELinux. This way
people such as Chris PeBenito and Dan Walsh can look over it and give
suggestions as well. You can find the list at the link below [1]. 

[1]http://oss.tresys.com/mailman/listinfo/refpolicy

Dave
