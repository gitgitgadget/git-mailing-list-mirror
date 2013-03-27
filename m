From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 27 Mar 2013 15:47:35 -0700
Message-ID: <20130327224735.GJ28148@google.com>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com>
 <20130327172909.532a30b6@hoelz.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	josh@joshtriplett.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Wed Mar 27 23:49:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKz8a-0003Cm-M5
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 23:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab3C0Wrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 18:47:40 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:51417 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab3C0Wrj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 18:47:39 -0400
Received: by mail-pb0-f50.google.com with SMTP id jt11so1226933pbb.37
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 15:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=w52r03cCF/qJxZqLGZHX/h29rW45G43jt8n6qJ/GmKk=;
        b=jhTUAe23b8wxnVuanqAxHjAM2VfBjKRmEyMDS/UL+g/OqA7o77BwkGjoTUvpu2AP7U
         3RZLBYvHt62woTT908648bbpHHrqBbh5DkpodWZc5fcGafKRc/m+TK6Jt32RClAGGoCZ
         Be60QWtP6zwEC8co4F3T/o7b9rxJM+vGchjprsoOhD4GBjEuV0wwN97X8h19hNJwHFRI
         3lTMVI+8lKpeDWRlnv7du2WROQgm69LRmuDIUseU60GZdctciQcSfcl1or+qz1NFUnIh
         krQXeN9lPKaOI+wCjOUoKrCNalM9quJ7jvZ3Wlx/PSkH/xotM8mULSO6DNP5NK4K09tW
         9yXw==
X-Received: by 10.68.11.35 with SMTP id n3mr31742816pbb.220.1364424459447;
        Wed, 27 Mar 2013 15:47:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id 1sm22931673pba.32.2013.03.27.15.47.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 15:47:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130327172909.532a30b6@hoelz.ro>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219346>

Hi,

Rob Hoelz wrote:
> On Wed, 27 Mar 2013 11:23:45 -0700
> Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Suppose I configure
>>
>> 	[url "git://anongit.myserver.example.com/"]
>> 		insteadOf = myserver.example.com:
>> 	[url "myserver:"]
>> 		pushInsteadOf = myserver.example.com:
>>
>> The above code would make the insteadOf rule apply instead of
>> pushInsteadOf, even when pushing.  Perhaps something like the
>> following would work?
>
> Are you sure?

The message you are replying to is nonsense, due to a typo while
editing.  Did you see my followup?

Sorry for the confusion,
Jonathan
