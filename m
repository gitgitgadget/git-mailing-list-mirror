From: Eric Hanchrow <offby1@blarg.net>
Subject: Re: git checkout -b -f v1.5.5.1
Date: Mon, 05 May 2008 09:03:06 -0700
Message-ID: <87zlr468n9.fsf@offby1.atm01.sea.blarg.net>
References: <dcf6addc0805050848v91589c6i6c2fca168b7644d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 18:09:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt3FX-0003QB-8V
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 18:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbYEEQIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 12:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbYEEQIX
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 12:08:23 -0400
Received: from main.gmane.org ([80.91.229.2]:48139 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbYEEQIW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 12:08:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jt3Ee-0005Md-TF
	for git@vger.kernel.org; Mon, 05 May 2008 16:08:17 +0000
Received: from q-static-138-125.avvanta.com ([206.124.138.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 May 2008 16:08:16 +0000
Received: from offby1 by q-static-138-125.avvanta.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 May 2008 16:08:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: q-static-138-125.avvanta.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:auTqfbm52FYjYjuinsykV7sycZY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81292>


    Hi, all
         I just mistaken 'git checkout -b 1.5.5.1 v1.5.5.1' to 'git
    checkout -b -f v1.5.5.1', and I don't how to delete it ,

      537  git-branch -D -f
      538  git-branch -D \-f
      539  git-branch -D "\-f"

         all the above operations were failed. :(

         PS: Would it be better if we do checking on branch name to avoid
    this case?

You could probably just

    rm .git/refs/heads/-f

and if necessary, replace the content of .git/HEAD with something else.

-- 
FIXME if it is wrong.

-- 

                               _
                              / )
              (\__/)         ( (
              )    (          ) )
            ={      }=       / /
              )     `-------/ /
             (               /
              \             )
             ,'\       ,    ,'
             `-'\  ,---\   | \
                _) )    `. \ /
               (__/       ) )   hjw
                         (_/
