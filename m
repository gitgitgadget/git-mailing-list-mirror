From: "Alan M. Feldstein" <alan@alanfeldstein.com>
Subject: mergetool for Solaris
Date: Thu, 14 May 2009 11:00:09 -0500
Organization: Cosmic Horizon
Message-ID: <4A0C4009.60406@alanfeldstein.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 18:08:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4dT4-0001PM-EC
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 18:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbZENQHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 12:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbZENQHY
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 12:07:24 -0400
Received: from smtpauth20.prod.mesa1.secureserver.net ([64.202.165.36]:60698
	"HELO smtpauth20.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751502AbZENQHX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 12:07:23 -0400
X-Greylist: delayed 410 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 May 2009 12:07:23 EDT
Received: (qmail 3727 invoked from network); 14 May 2009 16:00:31 -0000
Received: from unknown (24.206.112.173)
  by smtpauth20.prod.mesa1.secureserver.net (64.202.165.36) with ESMTP; 14 May 2009 16:00:31 -0000
User-Agent: Thunderbird 2.0.0.14 (X11/20080531)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119203>

    jesus% git mergetool
    merge tool candidates: kdiff3 tkdiff xxdiff meld gvimdiff opendiff emerge
    vimdiff
    No known merge resolution program available.
    jesus%


I tried building kdiff3-0.9.95. That wasn't much fun. (If any member of the Git 
community wants to explore that with me, I'll provide details.)

Searching for a path of least resistance, I used the above merge tool candidates 
list in comparison with the list of tool packages available from sunfreeware.com 
and selected tkdiff. Standalone, tkdiff launches successfully. But git mergetool 
fails to launch it:

    jesus% git mergetool
    merge tool candidates: kdiff3 tkdiff xxdiff meld gvimdiff opendiff emerge
    vimdiff
    Merging the files: about.html

    Normal merge conflict for 'about.html':
      {local}: modified
      {remote}: modified
    Hit return to start merge resolution tool (tkdiff):
    Neither ~/.dt/sessions/current/dt.resources nor
            ~/.dt/sessions/home/dt.resources was readable
       Falling back to plain X
    Error in startup script: expected integer but got "bold"
        (processing "-font" option)
        invoked from within
    ".client.left.text tag configure inlinetag -background DodgerBlue -font
    {TkFixedFont bold}"
        ("eval" body line 1)
        invoked from within
    "eval "$widget tag configure $tag $opts($tag)""
        (procedure "build-client" line 106)
        invoked from within
    "build-client"
        (procedure "create-display" line 40)
        invoked from within
    "create-display"
        (procedure "main" line 57)
        invoked from within
    "main"
        (file "/usr/local/bin/tkdiff" line 9515)
    merge of about.html failed
    jesus%

It seems to me inappropriate for Git to be looking for ~/.dt/ (which doesn't 
exist), because I'm running the Java Desktop System, not CDE.

Has anyone had success with mergetool on Solaris? Or can anyone help with 
mergetool/tkdiff (that looks solvable)?

-- 
*Alan Feldstein*
Architectural Verification Engineer, Cosmic Horizon 
<http://www.alanfeldstein.com/>
alan@alanfeldstein.com <mailto:alan@alanfeldstein.com>
*http://www.linkedin.com/in/feldstein*
	
work: +1 585 415 6682
See who we know in common <http://www.linkedin.com/e/wwk/1301367/> 	Want 
a signature like this? <http://www.linkedin.com/e/sig/1301367/>
