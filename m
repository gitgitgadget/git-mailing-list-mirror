X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Pierre Dumuid <pierre.dumuid@adelaide.edu.au>
Subject: Re: gitk feature request..
Date: Wed, 08 Nov 2006 10:36:36 +1030
Message-ID: <45511F8C.1060705@adelaide.edu.au>
References: <452A37FB.60507@adelaide.edu.au> <17745.1213.22769.420355@cargo.ozlabs.ibm.com> <7vslgu28do.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050901010202080604060600"
NNTP-Posting-Date: Wed, 8 Nov 2006 00:07:35 +0000 (UTC)
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
In-Reply-To: <7vslgu28do.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31103>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhayS-0005Lk-Lr for gcvg-git@gmane.org; Wed, 08 Nov
 2006 01:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753771AbWKHAHV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 19:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbWKHAHV
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 19:07:21 -0500
Received: from dogmatix.mecheng.adelaide.edu.au ([129.127.14.1]:31588 "EHLO
 dogmatix.mecheng.adelaide.edu.au") by vger.kernel.org with ESMTP id
 S1753745AbWKHAHU (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006
 19:07:20 -0500
Received: (from uucp@localhost) by dogmatix.mecheng.adelaide.edu.au
 (8.8.7/8.8.7) id KAA02086; Wed, 8 Nov 2006 10:34:21 +1030
Received: from UNKNOWN(129.127.14.10), claiming to be
 "watt.mecheng.adelaide.edu.au" via SMTP by dogmatix.mecheng.adelaide.edu.au,
 id smtpdc02077; Wed Nov  8 10:34:12 2006
Received: from WATT/SpoolDir by watt.mecheng.adelaide.edu.au (Mercury 1.44);
 8 Nov 06 10:36:47 -9:30
Received: from SpoolDir by WATT (Mercury 1.44); 8 Nov 06 10:36:36 -9:30
Received: from [129.127.14.23] (129.127.14.23) by
 watt.mecheng.adelaide.edu.au (Mercury 1.44) with ESMTP; 8 Nov 06 10:36:30
 -9:30
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format.
--------------050901010202080604060600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> Having said that, is the gitk view supposed to be shared across
> users of a single repository?
>   

> If you imagine yourself logging into kernel.org (perhaps X
> forwarded over ssh to your local machine) and browsing
> /pub/scm/git/git.git/, the repository itself would not be
> writable by you.  Even if it were, I do not think you would want
> me to reuse the view you used from there next time I did the
> same on the same repository.
>   
I've mainly been thinking about users at a home who clone / update a 
remote repository and work in that repository for themselves.  The idea 
of sshing into another machine seems to me not how git is designed to be 
used..

Also when one clones, I thought it cloned only the git repository, and 
not the files for the porcelaines. (an example being the branches directory)
> It might make sense to give --state=dir/ parameter to gitk and
> tell it to use that directory to keep persistent data.  Also I
> seem to recall you already have one file under $HOME/ to make
> window geometry or something persistent.
>   
I use gitk a lot, and I'd rather not have to specify a command line 
option all the time, but an override from using the settings in the 
another directory would be fine..


--------------050901010202080604060600
Content-Type: text/x-vcard; charset=utf-8;
 name="pierre.dumuid.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pierre.dumuid.vcf"

begin:vcard
fn:Pierre Dumuid
n:Dumuid;Pierre
org:The University of Adelaide;Mechanical Engineering
adr:;;;Adelaide;South Australia;5005;Australia
email;internet:pierre.dumuid@adelaide.edu.au
title:Postgraduate Student
tel;work:8303 3847
tel;home:8388 5727
tel;cell:0407570263
note:CRICOS Provider Number 00123M
x-mozilla-html:TRUE
url:http://www.adelaide.edu.au
version:2.1
end:vcard


