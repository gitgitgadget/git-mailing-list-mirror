From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [RFC] GIT Repository Annotation Convention
Date: Thu, 08 Sep 2005 14:58:29 -0400
Message-ID: <432089D5.7000102@gmail.com>
References: <87ll2aib73.fsf@gmail.com> <431DA8CD.9060009@gmail.com>	<432060B8.6080408@gmail.com> <7vr7bzv3r2.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 08 20:59:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDRbo-0005KV-TU
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 20:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVIHS6g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 14:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVIHS6g
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 14:58:36 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:4204 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964929AbVIHS6f (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 14:58:35 -0400
Received: by wproxy.gmail.com with SMTP id i2so1237028wra
        for <git@vger.kernel.org>; Thu, 08 Sep 2005 11:58:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=J2vF/p3K/IIfGi51U5s7lvdjI+6yidGkoPNtEomvoG3BckNd4T9ZjBNk+y90IjbanTfBdIJgwTrlz3Y3V6UZE5fNMkxceQT3NmkO5zsv83nxSkyV27Acq2lsE/QPHiUnCTO8Udi9t7ewFyOdU6XfsiKFPe0yE1Pkk4UGhsLrSMQ=
Received: by 10.54.53.7 with SMTP id b7mr4830100wra;
        Thu, 08 Sep 2005 11:58:34 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id g9sm806170wra.2005.09.08.11.58.30;
        Thu, 08 Sep 2005 11:58:32 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: git Mailing List <git@vger.kernel.org>
In-Reply-To: <7vr7bzv3r2.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8211>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>>Naming and Directory Structure
>>------------------------------
>>Annotations are named by appending ".txt" to the basename of the
>>repository component it describes, and by appending ".dir" to each
>>directory patch component leading to the repository component from
>>$GIT_DIR, and by prepending "annotations/" to the annotation pathname.
> 
> I suspect you can do the same without .dir but only with .txt.

Think about a directory containing directories "foo" and "foo.txt":

With ".dir":
	foo.dir/
		...
	foo.txt
	foo.txt.dir/
		...
	foo.txt.txt

Without ".dir":
	foo/
		...
==>	foo.txt
==>	foo.txt/
		...
	foo.txt.txt
