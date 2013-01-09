From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: Re: GIT get corrupted on lustre
Date: Wed, 09 Jan 2013 16:20:18 -0500
Message-ID: <50EDDF12.3080800@giref.ulaval.ca>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Brian J. Murrell" <brian@interlinx.bc.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 22:21:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt35W-0007Bm-4b
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 22:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933565Ab3AIVVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 16:21:08 -0500
Received: from serveur.giref.ulaval.ca ([132.203.7.102]:32814 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933252Ab3AIVUY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 16:20:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 714AF1020A5;
	Wed,  9 Jan 2013 16:20:19 -0500 (EST)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FSxOsROZ3dJR; Wed,  9 Jan 2013 16:20:18 -0500 (EST)
Received: from [132.203.7.22] (melkor.giref.ulaval.ca [132.203.7.22])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id BBD631019AA;
	Wed,  9 Jan 2013 16:20:18 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50EC453A.2060306@giref.ulaval.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213105>

Hi Brian,

On 01/08/2013 11:11 AM, Eric Chamberland wrote:
> On 12/24/2012 10:11 AM, Brian J. Murrell wrote:
>> Have you tried adding a "-q" to the git command line to quiet down git's
>> "feedback" messages?
>>
>

I moved to git 1.8.1 and added the "-q" to the command "git gc" but it 
occured to return an error, so the "-q" option is not avoiding the 
problem here... :-/

command in crontab:

cd /rap/jsf-051-aa/ericc/tests_git_clones/GIREF && for i in seq 10; do 
/software/apps/git/1.8.1/bin/git gc -q || true;done

results:
error: index file 
.git/objects/pack/pack-1f09879c88cd71a15dcc891713cf038d249830ad.idx is 
too small
error: refs/remotes/origin/BIB_Branche_1_4_x does not point to a valid 
object!

and this clone was a "clean" clone in which only "git qc -q" has been 
run on....

I still have a doubt on threads....

Eric
