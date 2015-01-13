From: Gunnar Wagner <gunnar.wagner@irisgermanica.com>
Subject: commit --amend --author   error
Date: Tue, 13 Jan 2015 16:15:36 +0800
Message-ID: <54B4D428.2050300@irisgermanica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 10:04:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAxOS-0002cP-6h
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 10:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbbAMJEC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 04:04:02 -0500
Received: from filter02.hostcontrol.com ([5.157.86.49]:49942 "EHLO
	filter02.hostcontrol.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750968AbbAMJD6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jan 2015 04:03:58 -0500
X-Greylist: delayed 2855 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jan 2015 04:03:58 EST
Received: from server21.firstfind.nl ([85.158.203.19])
	by filter02.hostcontrol.com with esmtp (Exim 4.84)
	(envelope-from <gunnar.wagner@irisgermanica.com>)
	id 1YAwe8-00022t-VO
	for git@vger.kernel.org; Tue, 13 Jan 2015 09:16:21 +0100
X-Virus-Scanned: by amavisd-new-2.7.1 (20120429) (Debian) at firstfind.nl
Received: from [192.168.1.241] (unknown [180.175.31.9])
	by server21.firstfind.nl (Postfix) with ESMTPSA id 8A85EE3809A
	for <git@vger.kernel.org>; Tue, 13 Jan 2015 09:15:47 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
X-Filter-ID: s0sct1PQhAABKnZB5plbIUVx/rf7XrQZD/WuU7RgLq18NbHzBNM6ueNDbfTXO2E7RrTcBjhBQfKV
 qUjBKRcghYFM4QNE1WZ9qRma6gWU8Ra3wL2Y4F0412ezGCyTUPanW/eZinF9OW94AfSjC/VrtBDP
 PxWMkTB/mmm+kptDKIie+osR4+sgyQt2lL5zIl3W7GaTPmOYfIvbtvHCZcp9M1FfEoXm0/FPF8PR
 0w363lmFs5sTLokZVdR8uCC+YJnqeZGMARYx0l9ckgEjGO0PJIxGe9KFq5jc+eUON/wsKROWhvcP
 8jC1ZkX2VZpmrGw/0ALn042Wb7mIcbVJi7pqppGBoY7R/+BTWm6nHPpCotsiYcgD1Ig41R8/GoQ/
 6FxJSSzm7P5LFQTh7xAIEq/JACGZCt4Q02ctmf9a+hie0Pf3b0GeVJ/F+cNCGCANQPYzttEXQn4A
 vqBFHAVy3LT9EQBc7Rt3/kE5N8dYN72MeGjbsocQfQap5I8xo0Cx/9Cv1lIMPyoPJ8Ez4j4SYUIK
 QStQB6xVcqPjUBHmDoe5KzQZ/E2WFDJmZLdOAvDYDohi8CFrg37AZp9QvG5X+Mp71RTKfL8vs9My
 wj6+3amC/LcamUdylUIKhf3z2GAHxH7IMlkKPUSbBEyKqr1+wOgZ4pl6iYLbgxdHjUPPtd9Smf2v
 ov8D0m2OA5joP3tjRB1AMV97O+jzobCKrmqA9aS5Ww==
X-Report-Abuse-To: spam@filterapi.hostcontrol.com
X-Filter-Fingerprint: IFrWXGses7OKB5S5G8/dJdF8bCbRCAhGucQF+2hmonpA3cTUQ1R++keuE7RDJ8Kg3RbMLUalw1oC
 mj99/u+PoqoVy8a3lsStJtAvpObFX0W9pwnCLfzqMQ4SqlQant4mUpndEJ0YoaLytXXo8BMTaX2p
 Mk7LBarWD9Fj4R3eIu5cOy/3Wm9qfF/CZNvP/2Kowv61T+KDYyYtREgszdyFwv8IxCB3p/oCKvxr
 eyISh3JGb7OS5oVgiO+kDxZrVPLz3MmEGC2PrUKqLq5WmHK+Nw==
X-Originating-IP: 85.158.203.19
X-Hostcontrol-Domain: out.yourhosting.nl
X-Hostcontrol-Username: 85.158.203.19
Authentication-Results: hostcontrol.com; auth=pass smtp.auth=85.158.203.19
X-Hostcontrol-Outgoing-Class: unsure
X-Hostcontrol-Outgoing-Evidence: Combined (0.34)
X-Recommended-Action: accept
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262331>

I got APGL licensed code from someone else and want to post it on my 
github (without taking credit for the work)

tried   git commit --amend --author="Author name, www.website.com" but 
got an error message which said something like "original author not found"
Can it be that the --amen --author only work if the author is on github 
himself?
