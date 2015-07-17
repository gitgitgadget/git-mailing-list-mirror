From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] Fix detection of uname failure
Date: Fri, 17 Jul 2015 23:07:55 +0200
Organization: gmx
Message-ID: <7cf6757e8e81c2f9e102db24efbedb2a@www.dscho.org>
References: <ef7d56584c3b5d6431f895df1d94eba8@www.dscho.org>
 <1437152981-28855-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jul 17 23:08:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGCrk-0003O8-8I
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 23:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbbGQVIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 17:08:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:62206 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbbGQVIK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 17:08:10 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Ld0E0-1YYJO11DQe-00iG1x; Fri, 17 Jul 2015 23:07:57
 +0200
In-Reply-To: <1437152981-28855-1-git-send-email-charles@hashpling.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:LlHQNFU16DKVJ6u+95Kljq0goSjPcYC4hX/afZtqnfEAyvP1FFV
 mOUD2XFebMzmKlLYdWD8vbI0iGLR7Msr4fA6jtnIBV0QXEMYP+s5jYr16Vc28i2grQGRxmC
 kFLEnizR18OWFe+B9qIw4O0lL0aKP0LBjoQxCaAhT5eb3Vv99ie3YLF+oHF8SrOINVbD9Mf
 m0Befah/nnwyyjjY1ZHoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:62Pdhxc6ueA=:knr0QFIcw7F220v/rNzLOd
 mAMZiGvsw5hW5XOgKHzvihWcPgtIgJVODDCKJru1IH3ziBEBoTzXp/0ApBPvaqpbJM088S1bp
 w3I+jANnyYL34bhXqiZEpjUowlQmadp5LRO3HbfBXmXEF0mu2Dg5rVoJN1rl6v7v+NGAX/kI/
 0TmsTq2OYxYo8Bq3w8EfZLIAe0RdOQi8OESM7ocJL1IpoX9IN8HMFIgllXmv0t3MZ1E4xvNGD
 mWwBSptt9n+JDKwl0JNpUoIDg4DAGj1NYgZIG9RvzQpRKl6jz7+bHSWvfynE438bMX5As3mSW
 P8riJJ1iIjVWWNtQcsfmufAo/DpLzF7QGxcQcp89QDzTKYxEcLK/37yGQQCBTKo5B06uyIMdZ
 /AQUw/KqmQ2EVZGLruhIhr7nWa24FZJlb7cP90EbzWtSib0KBZe/Dbl/Q0iGBvCrtZfcGzAaa
 uoCNCjw5aOuiq37T8/R3RwOiInBkLlbgnzCwlIAGh/S3PMbkeg60MW4lc0E7pvoHYqkjOwtgI
 4VlhuILhdK+v2/cCytlVFLozuwXQdhn83Db8j/kY7O3UYnmRUZPdF0nITIhPDiv0GRxmfbGYE
 G+7fdahndnglXmCuIktiQFgr2cC3euqcB9hLCZd7ZUS4IqtggrZls9eUA8qoJF6kUsMjjspc1
 /6uNAJl5ncwVf44UoVSDpE1KEAMNju9ppixU31cLHxlVxk67qqALBWR6gaCtRcxFmWJE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274102>

On 2015-07-17 19:09, Charles Bailey wrote:
> From: Charles Bailey <cbailey32@bloomberg.net>
> 
> According to POSIX specification uname must return -1 on failure and a
> non-negative value on success. Although many implementations do return 0
> on success it is valid to return any positive value for success.  In
> particular, Solaris returns 1.
> 
> Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
