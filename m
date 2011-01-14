From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: working with a large repository and git svn
Date: Fri, 14 Jan 2011 10:23:59 +0100
Message-ID: <4D30162F.5060408@alum.mit.edu>
References: <AANLkTimKbS3ECzOaGtNgvx7DThJGH_DkPmg4ehKXGtwc@mail.gmail.com> <201101120830.47016.wjl@icecavern.net> <20110113032300.GB9184@burratino> <AANLkTikCvjDqUpL-=srVKcMQx+NM6bV7FabmJ+4sPqD7@mail.gmail.com> <20110114080554.GA1735@kytes> <20110114082931.GC11343@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Joe Corneli <holtzermann17@gmail.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Love_H=F6rnquist_=C5strand?= <lha@kth.se>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 10:24:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdftF-0003XO-Tt
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 10:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab1ANJYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 04:24:09 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:48206 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab1ANJYH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 04:24:07 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p0E9NxUi027880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Jan 2011 10:23:59 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <20110114082931.GC11343@burratino>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165085>

On 01/14/2011 09:29 AM, Jonathan Nieder wrote:
> . Is svn okay with non-monotonic dates?  (If not, then the committer
>   date would need to be used.)

Subversion can tolerate non-monotonic dates with one caveat: it breaks
the find-revision-by-date feature (e.g., "svn update -r '{2010-12-25}'")
for the time intervals with non-monotonic dates.  This is a seldom-used
feature and therefore its sacrifice is often accepted, for example when
the history of the Subversion project itself was migrated into the
Apache project's Subversion repository.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
