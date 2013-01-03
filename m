From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Pretty pictures of git merge conflicts
Date: Thu, 03 Jan 2013 17:37:18 +0100
Message-ID: <50E5B3BE.7080500@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 03 17:37:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqnnY-0007t1-LY
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 17:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580Ab3ACQhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 11:37:22 -0500
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:58125 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753248Ab3ACQhV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jan 2013 11:37:21 -0500
X-AuditID: 12074411-b7fa36d0000008cc-98-50e5b3c07c3e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 47.72.02252.0C3B5E05; Thu,  3 Jan 2013 11:37:20 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r03GbIaM012473
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 3 Jan 2013 11:37:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsUixO6iqHtg89MAg7NfJS26rnQzOTB6fN4k
	F8AYxW2TlFhSFpyZnqdvl8Cd8ff7U8aCX2wV//ZdY29g/MLaxcjJISFgIvFn13w2CFtM4sK9
	9UA2F4eQwGVGiZObPrNAOA+YJN6fXwTkcHDwCmhLTDoC1swioCrx/95EdhCbTUBXYlFPMxOI
	LSoQILF4yTmwOK+AoMTJmU9YQGwRoJpdz66CLRMW0JdYd+kXWJxZQEfiXd8DZghbXmL72znM
	Exh5ZyFpn4WkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJTSjcxQoJJ
	cAfjjJNyhxgFOBiVeHhX1zwJEGJNLCuuzD3EKMnBpCTK+2/D0wAhvqT8lMqMxOKM+KLSnNTi
	Q4wSHMxKIrycK4ByvCmJlVWpRfkwKWkOFiVxXr4l6n5CAumJJanZqakFqUUwWRkODiUJ3heb
	gBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQREWXwyMMZAUD9DeeSDtvMUFiblA
	UYjWU4zGHLcabj5l5Lg/HUgKseTl56VKifMWbQQqFQApzSjNg1sESyOvGMWB/hbmrQAZyANM
	QXDzXgGtYgJa9erNY5BVJYkIKakGxqZ9M1bHNeQoWRl+3HEts+zCpweqp//I1jz97a7HvS5P
	ZU2wjaZPzNHNpa23mM5e4rnsJDr/smtSX8mxlHdrN38p9O42tr088/GzL2s8xB3Yq6+vqdzq
	dTN5XoV2a+IlO6HXF5qMuFfu8NBYcTq7SU1I3+fLyRObTZ8zlN5cOVm3ILlG4tfG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212597>

Hi,

I've been thinking lately about how to attack difficult git merge
conflicts.  The first step is to visualize them.  I have written some
articles [1,2,3] describing a way to atomize a complicated merge and
efficiently compute diagrams that show which pairwise commits cause the
merge to go awry.  I hope you find them interesting; feedback would be
very welcome.

I am working on some more articles (including software) that I plan to
grow into tools to help users perform git merges that would otherwise
seem hopeless.

Michael

[1]
http://softwareswirl.blogspot.de/2012/12/the-conflict-frontier-of-nightmare-merge.html
[2]
http://softwareswirl.blogspot.de/2012/12/mapping-merge-conflict-frontier.html
[3]
http://softwareswirl.blogspot.de/2012/12/real-world-conflict-diagrams.html

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
