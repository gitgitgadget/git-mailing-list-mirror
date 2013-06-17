From: Joel McGahen <vin4bacchus@me.com>
Subject: Re: New User Question
Date: Mon, 17 Jun 2013 12:56:53 -0400
Message-ID: <1786A257-B21A-46CC-8F41-31AE9B948C00@me.com>
References: <F201B6D6-7A69-4DD6-BDF5-5AE12E3A176C@me.com>
 <CABjHNoSfLGW_D8RM8+LghP8kKYsYhZKi=7k4kEJSNEX=PDe2XQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: William Swanson <swansontec@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 18:57:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uocju-0007u2-BE
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 18:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab3FQQ5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 12:57:05 -0400
Received: from st11p02mm-asmtpout005.mac.com ([17.172.220.240]:64671 "EHLO
	st11p02mm-asmtp005.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752801Ab3FQQ5D convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 12:57:03 -0400
Received: from [192.168.1.211]
 (c-66-176-70-142.hsd1.fl.comcast.net [66.176.70.142])
 by st11p02mm-asmtp005.mac.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Jan
  3 2012)) with ESMTPSA id <0MOJ00E33R30G160@st11p02mm-asmtp005.mac.com> for
 git@vger.kernel.org; Mon, 17 Jun 2013 16:57:03 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.10.8794,1.0.431,0.0.0000
 definitions=2013-06-17_04:2013-06-17,2013-06-17,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 ipscore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=6.0.2-1305010000
 definitions=main-1306170132
In-reply-to: <CABjHNoSfLGW_D8RM8+LghP8kKYsYhZKi=7k4kEJSNEX=PDe2XQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228084>

Thanks William. You response is much appreciated. 

Should I have just changed the origin URL in the first place to point to my new local repo? What I did was to just add another remote with a different name (temp_repo). So if I do "git remote" I see origin and temp_repo. I then pushed to "temp_repo". 

Or should I have pushed as I did and then change the origin to the new repo location? So If I would "git remote" i would still only see one (origin) but it would point towards the temp_repo location?


On Jun 17, 2013, at 12:51 PM, William Swanson <swansontec@gmail.com> wrote:

> On Mon, Jun 17, 2013 at 8:39 AM, Joel McGahen <vin4bacchus@me.com> wrote:
>> What I need to understand is how to
>> a) Connect my developer's VM local repos to the new remote repo I created so they can continue to work.
>> b) Once the contractual issues are resolved reconnect the developer's local repos back to the original orgin/master repo and merge all their changes.
> 
> Git stores information about remotes in the .git/config file. You can
> either edit this file directly to change which URL "orgin" points to,
> or you can use the "git remote" commands to make the same changes. You
> can read the documentation by typing "git help remote".
