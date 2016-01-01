From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: t6023 broken under Mac OS
Date: Fri, 1 Jan 2016 16:36:48 +0100
Message-ID: <56869D10.9090105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: dev+git@drbeat.li, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 01 16:37:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aF1ly-0004Zf-Ni
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jan 2016 16:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbcAAPg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2016 10:36:58 -0500
Received: from mout.web.de ([212.227.15.4]:63097 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbcAAPg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2016 10:36:57 -0500
Received: from [192.168.2.107] ([79.223.114.113]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M5flQ-1a3vzQ1DZo-00xd0y; Fri, 01 Jan 2016 16:36:52
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.0
X-Provags-ID: V03:K0:GDxbQt9jeh4b5zIJJT8/FIAqKceHMETL2rHNWTeaxknsfx4p8Nm
 vz3esLaYQiaE5BLb6GL4laaRMWa3ACqdKrd6ZoVV7g4lo6BBsOHDostG6oyYwxZYVcmTEkF
 EnQkjPDsifs/M0XLL89hUviKy93wDsnh0YgDomg7/1R97HH5/to2pE1PqnNa/L2URi5P7Yw
 CZXAexKSV/kjfZ6G+u0Qg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GRMIWE1U4sg=:Ncqy8f7aPOA5Vy66B6qDmi
 WgR40urhCWM2Sf1C6+4UAUTxkwd7mDRoVdcBD1BJlgMhV9X7tOAFvR1MrE1FOt2vftS+nL0uJ
 CxIQ+a9Z1jUtStdhnd+kkCBFltMR7JxJXxUKn/k1X+PP2hOA04xTznYjUTsWmbLOa8LuxJv2R
 e4t0/+KepVr+t4hjHSgBywZbhzCRUHaadvWEiBGkV+MlVlT5eu/LWRMwziijkB+T+VPCScyUW
 uo4VIjL6h5ZXdks9K8pQ1zHEEsn+On7wSyxh8F7bz3sl1oEtzhyTRbB8gH6XfJ2/ndv+cTkFs
 9tZqBXGGUG59yDeu5aM8IEL6+E9jKqW4TgeEpif6l3pAV++c8YOzNOxIo0P+ES2+41E4q7meF
 wgQeomZZx7fz7NxFspEklFyJvvu0etXkiBwgoUX4z54mw5MHsK46VZ2Dj+rJBILxlws40VaR4
 cBbHoOokSe3cBoJXZ7NwdB8dJ1R/i0Ei6GsGV1+zjlpbOZkGkBmvn2SUGLh+Lo/D7cBwq/dVj
 CE7cQnKhqdGu7HTYeGe8C7/+FHPSA8Ou2ytUcyr3+OEgq54pVVFgy2fLQg7gDBLu3AHJO5Zif
 d7KSxfgwk9GRCRVBSzep2moUdKsascoCKrxZnmbv8Ipo2QYgItMoL2IeVZGi73EWCGvM1GfJm
 r+mNUylj4GMJU/Va9/ZqNpvTzK6++GG6MHKEcQHSPzfQa3B7Iqq+hhDWjRbZVGHO3ftPgnMwo
 UxzuH91e6uSR+Y6np0JmNFoNoCADgtG9e3FCUWqge4Z15zkqURAe2RFANudhy9a7jS2NECre 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283256>

The (last) test case
'conflict markers contain CRLF when core.eol=crlf'

does not work as expected under Mac OS: "wc -l" is not portable and the line
test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 3
fails.

(The other problem is that the usage of "\r" in a sed expression is not portable
either.)

In other words: I don't have a solution at hand.
