Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CF0D1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 22:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752621AbeFEWTv (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 18:19:51 -0400
Received: from elephants.elehost.com ([216.66.27.132]:42995 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbeFEWTu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 18:19:50 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w55MJLod051569
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 5 Jun 2018 18:19:21 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Heinz, Steve'" <SHeinz@aaanortheast.com>, <git@vger.kernel.org>
References: <BN7PR15MB23394E6E4AB05C17287E8F55BB660@BN7PR15MB2339.namprd15.prod.outlook.com>
In-Reply-To: <BN7PR15MB23394E6E4AB05C17287E8F55BB660@BN7PR15MB2339.namprd15.prod.outlook.com>
Subject: RE: git question from a newbie
Date:   Tue, 5 Jun 2018 18:19:12 -0400
Message-ID: <000901d3fd1b$3eeb7900$bcc26b00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGZnygOe1TPCQlnto8dL1AfgSBrSKTG98Mg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 5, 2018 5:24 PM, Steve Heinz wrote:
> I am new to Git and have read quite a few articles on it.
> I am planning on setting up a remote repository on a windows 2012 R2
server
> and will access it via HTTPS.
> I am setting up a local repository on my desk top (others in my group will
do
> the same).
> On "server1":  I install Git and create a repository "repos".
> On "server1":  I create a dummy webpage "default.htm" and place it in the
> repo folder.
> On "server1":  I create a web application in IIS pointing to Git
> On Server1":   change permissions so IIS_User  has access to the folders.
> On "server1":  inside the "repos" folder and right click and choose "bash
> here"
> On "server1":   $ git init  -bare    (it's really 2 hyphens)
> 
> On Desktop:  open Chrome and type in URL to make sure we can access it
> https://xyz/repos/default.htm
>       ** make sure you have access, no certificate issues or firewall
issues.  The
> pages shows up fine
> 
> On Desktop:  install Git and create repository "repos".
> On Desktop:  right click in "repos" folder and choose "bash here"
> On Desktop:  $ git init
> On Desktop : add a folder "testProject" under the "repos" folder and add
> some files to the folder
> On Desktop:  $ git add .                 (will add files and folder to
working tree)
> On Desktop   $ git status               (shows it recognizes the filed
were added)
> On Desktop   $ git commit -m "test project commit"           (will stage
changes)
> On Desktop   $ git push https://xyz.domainname.com/repos master
> 
> ** this is the error I get,  I have tried many different things.  I am
sure I am
> doing something stupid
> ** I have tried a bunch of variations but I always get the same error.  It
looks
> like some type of network/permission
> ** thing but everything seems OK.
>        Fatal: repository 'https://xyz.domainname.com/repos/' not found
> 
> *** this is where I get the error trying to push staged items to the
remote
> repository.
> *** I have tried to clone the empty remote repository still same error
> *** I checked port 443 is opened and being used for https
> *** tried to set origin to https://xyz.domainname.com/repos" and then $git
> push origin master   (same error)
> *** I tried passing credentials to the remote server as well

Missing glue - git remote

git remote add origin https://xyz.domainname.com/repos

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



