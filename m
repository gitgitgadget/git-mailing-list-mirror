From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Sun, 03 Sep 2006 13:52:15 +0200
Organization: At home
Message-ID: <44fac1ee.308dbbaf.574b.08a5@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 03 23:26:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJzTc-00037k-SQ
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 23:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWICVZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 17:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWICVZ5
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 17:25:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:37955 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751298AbWICLwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 07:52:16 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1389256uge
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 04:52:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:subject:to:date:lines:organization:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=SzArPyaq/3dtp1J4kGdF1psdxa116rTwv8L4hmERPtVOtNWoJ/TiG4lZ5WlIrwThzzoo/Z1797Nj9sDSF7qK45Nhn+vH51Fhp4li5+MTp7Wg6UqbN8+BPNO6YjoiY/xYsZcQDXSVAxTSP9tActfCxrCGQVln/iDnBqCR8EiKt8k=
Received: by 10.67.100.12 with SMTP id c12mr2236231ugm;
        Sun, 03 Sep 2006 04:52:14 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id k30sm6386741ugc.2006.09.03.04.52.14;
        Sun, 03 Sep 2006 04:52:14 -0700 (PDT)
To: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26380>

Marco Costalba wrote:

> On 9/3/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> Marco Costalba wrote:
>>
>>> On 9/2/06, Jakub Narebski <jnareb@gmail.com> wrote:
>>>>
>>>> By the way, do the diff between arbitrary revisions (say, between two
>>>> branches/two refs) and between arbitrary versions of the same file
>>>> would be useful to have in gitweb?
>>>>
>>>
>>> A nice tool, lot of ideas to steal ;-)
>>>
>>>http://www.cenqua.com/fisheye/demo/viewrep/ant/src/main/org/apache/tools/ant/?FETOUR=A1
>>
>> FishEye? I haven't took the full tour, but the tool seems somewhat
>> CVS centric, i.e. per file history, file description,...
>>
>> But for example "breadcrumbs" idea for the file path (each segment
>> of path being link to given (sub)directory) is a nice one. Although 
>> if I remember correctly the pathname (for files only) is currently
>> hack to have somewhere link to "head" version of current file in
>> plain format. 
> 
> Also the UI for diff between arbitrary revisions could be interesting.

There is problem with git encouraging multiple branches and nonlinear
history. While it would be fairly easy either to add Wiki-like (e.g.
http://git.or.cz/gitwiki/ or http://en.wikipedia.org) radio-boxes to mark
revisions to compare, or add pull down menu to select revision (useless
with longer history) of a given file (we have diff-to-current in file
history, by the way), the true power of selecting revisions to compare
would be when we would have graphical history visualizer built in, similar
to gitk and qgit. 

By the way, do you known any common Perl modules for generating PNG
(graphs)?

P.S. This message seems to hit VGER BOGOfilter... ehhh...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git



-- 
VGER BF report: S 0.999997
