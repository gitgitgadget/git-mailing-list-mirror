From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: t5551 hangs ?
Date: Wed, 11 May 2016 19:13:56 +0200
Message-ID: <db56fae5-799a-29af-3a0f-a7b5c671063a@web.de>
References: <cover.1462774709.git.johannes.schindelin@gmx.de>
 <cover.1462863934.git.johannes.schindelin@gmx.de>
 <ff8cbab7e62211b13835e520d402fbd89b90849e.1462863934.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 19:14:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Xi8-0007SL-QY
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 19:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbcEKROI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 13:14:08 -0400
Received: from mout.web.de ([212.227.17.11]:60351 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbcEKROH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 13:14:07 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MEVYz-1apFAp3kAj-00FnmS; Wed, 11 May 2016 19:14:03
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <ff8cbab7e62211b13835e520d402fbd89b90849e.1462863934.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K0:kr4KhkdUvcAdVXZsN17BBqMampBDt90n5cKAMQ9BKE2aKcPqX2I
 7F5CcqPu63WP4KEa2NgoROsTMJ7D9AkjFqK2kJN64mpmhtPfoEOGhuEb1ZniPS+JnKFa7Ta
 yE88qE4m3ZjXp1Bwt92zbPviSP8g+MFUDDWg/Q1zzpgT74UTzuSZsOA2xCNdh9flwPmLIo3
 O1hIp/F0seKmgiFOj262w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EAmpPsqT0aQ=:HqWRyoXGSyImUNh+kJOoN+
 TiA0WFfL1dOPGL9ImlKL2Mju7+WIuaGLonOO3i1aOlduYIxRg1M0vDt6X4XM2orirfySiWi9B
 +NdRMBnYOZpBajGFXQjo+Pyydv4G6jafCTxvOkrb9pWIYALdJ5hr3CEB0ILaQvK+2pBklCn7r
 n8sjMBL/9/8Wdf9DB7m2iYE7IYs/j0SVjXA5uNWlj3E6AdFt3gmGa3B+9CzlPdpUOfEK3OHke
 7B3wpvd46b9AiJZy0r3gd1nHGrzddj7dNqWlZCYEE/Aem3pnr8hpzV+sQjrcepXuex4mqnGys
 NM3+O2iQ1IPTrLjzdIqDMnfotn9q2DT9QAWxEp0+K1h1JKVgkzpOjL5hQHhKTtaffrfEaV8tY
 p8FR9swJG6G/D5Z+2BluG6GOQq5P7tNJeQvnzMh2RPlhinxeTZdHn1VMR59AitJoad7WQxDaG
 PFNkXtxguuuZHdcThi56Z8uVs0EUdzblY/oSsVKf46FqdnSO6v+2RgASpqZBK9Tq50/60H6AZ
 mEf7NmE1WKdOzTOtziMRAZdsZZcD4af5ZfS9T0CGtIw2vQ5PwSvonvcTxCQveQNU8fBcV4WLh
 HPSnTAgfEmSey/JyzWMvg9di0uhPLQOWsRW0jkeJljDdIpCUuGnB2pYwWitnJUaxPFbmBT3v5
 ckDLc0DMWT52JYCCraAGC0sn5nxwCBF7b3NbNnYWxIYli2xj1uh3Od56aCzTwTqk5oC6adu9C
 xbg590g3McU3i5GGRjXBMBdUDZsG4hKT2uE6hOJAWVEoEDtETrcn0zLuv6qgD6i+L5sGOh/J 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294353>

On 10.05.16 09:08, Johannes Schindelin wrote:
- I'm not sure, if this is the right thread to report on -

It seems as if t5551 is hanging ?
This is the last line from the log:
ok 25 - large fetch-pack requests can be split across POSTs

I have 7 such processes running:
/trash directory.t5551-http-fetch-smart/httpd -f
/Users/tb/projects/git/git.pu/t/lib-httpd/apache.conf -DDarwin -c Listen
127.0.0.1:5551 -k start

This happens both under Mac OS X and Debian.

Does anybody have the same hanging ?
