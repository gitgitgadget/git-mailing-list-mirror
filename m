From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: Git pull doesn't get the tags
Date: Fri, 22 Oct 2010 11:04:32 +0200
Message-ID: <4CC153A0.7080605@debugon.org>
References: <20101022053747.a5427cad.coolzone@it.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rico Secada <coolzone@it.dk>
X-From: git-owner@vger.kernel.org Fri Oct 22 11:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9DYI-00060f-Of
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 11:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759Ab0JVJEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 05:04:36 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:51589 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab0JVJEf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 05:04:35 -0400
Received: from [192.168.2.102] (dslb-088-071-188-252.pools.arcor-ip.net [88.71.188.252])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0M7DTa-1OOWYR3eHm-00x7JV; Fri, 22 Oct 2010 11:04:34 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
In-Reply-To: <20101022053747.a5427cad.coolzone@it.dk>
X-Provags-ID: V02:K0:+4mwav3u3GZ6OFtL00ryga6d9r8pmqvhYX7fSRo3Ulh
 LLAF1KS7Y+rMoZ5Me8Kw1nW8eKAl2/rMYPg8wre7Jo7lDVEbhq
 XpbHER/o+mqTgX52OUIcQ7s6/f2FHdiLMmrWVoFK+0AvxEiNq6
 FyCBwpYjUlLq6P7k0D3M2l4sYsuxXEZuAft3ltS5vSxNAy3RhD
 AdiWypXRaeSjtPxh9b0Qs6zkNIR6hMRlxX06Sb3rTo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159669>

On 10/22/2010 05:37 AM, Rico Secada wrote:
> Hi.
> 
> I am working on a repo on my desktop and I got a clone on my laptop.
> I needed to pull the new stuff from my desktop unto my laptop, and I
> noticed that tags doesn't get pulled.
> 
> The laptop access the desktop using NFS and I am using "git pull
> NFS_SOURCE".
> 
> The repos are identical except that a few files has been updated and a
> new tag has been added.
> 
> Why doesn't pull get the tag?
> 
> Best regards.

Try git pull --tags.

>From git-pull's manpage:

-t
--tags
        Most of the tags are fetched automatically as branch
        heads are downloaded, but tags that do not point at
        objects reachable from the branch heads that are being
        tracked will not be fetched by this mechanism.  This
        flag lets all tags and their associated objects be
        downloaded. [...]

-Mathias
