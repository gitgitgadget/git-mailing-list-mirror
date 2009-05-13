From: Ittay Dror <ittay.dror@gmail.com>
Subject: switching upstream tips
Date: Wed, 13 May 2009 09:42:25 +0300
Message-ID: <4A0A6BD1.7050907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 13 08:43:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M48BG-0002hF-DB
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 08:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbZEMGme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 02:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbZEMGmd
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 02:42:33 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:54417 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbZEMGmd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 02:42:33 -0400
Received: by fk-out-0910.google.com with SMTP id 18so216886fkq.5
        for <git@vger.kernel.org>; Tue, 12 May 2009 23:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=NwjN4b5Tvf+olmprue6meF3H3DZezdvxL6bSOG+vD1Y=;
        b=sDzRhcuklSc2Ps/H9hQGedAx6AyWqrd0/R/rd0lyOYjugyDSo3qhU7SSTnPJmOcdBR
         qCKpeXeDuu7OoWAj66Yi6qwueb4DKp/c1+SaSHYJXAqLOU5T75olMgz+LnYr4LbnCjX5
         3TIdZJUSZNMKi1GlA4KsLUm0TRxS8PrnZFzM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=QKKftw3h017lI3Mvi6TYLDqtp83N+6YcOPG62u5O/Md6amQvIoWIUAEU6zKp2NR7pG
         kPW4i/tlCK7n6styE2VOXhzeB1HCKws6sTYGKwPX052icwlycRkAVC0vwBiRhuz064V9
         JLUIXKIMuXJyxHWLjXof/tYABHzIElb770Kh0=
Received: by 10.103.172.9 with SMTP id z9mr391054muo.58.1242196953010;
        Tue, 12 May 2009 23:42:33 -0700 (PDT)
Received: from ?10.10.2.8? ([212.143.191.180])
        by mx.google.com with ESMTPS id 7sm1896991mup.54.2009.05.12.23.42.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 May 2009 23:42:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118988>

Hi,


I'm working on a repository in github that is forked from another 
repository. I've committed several times and pulled (merged) from the 
upstream a few times (so the committs are interleaved). The upstream 
repository is a clone of an SVN repository (in apache). The project has 
switched svn repositories (moved from incubation to top level project) 
and so created a new repository in github.


Now I want to start working with the new upstream repository. My problem 
is that because of the changes in the backing SVN, the objects are 
completely new, so when i try 'git pull new-upstream master', I get a 
lot of add/add conflicts. Most of the conflicts show the whole file has 
changed while actually just a few lines differ. So I'm having trouble 
making sense of the mess.


What I'm trying to figure out is how to do the following:

* Reorder my history so that my commits are on top of the tip of the old 
upstream repository.

* Change the upstream repository reference so it points to the new 
repository

* Apply my commits on top of the new upstream repository


Of course any other alternative which will allow me to continue to work 
with the new upstream is also welcome.


Thank you,

Ittay
