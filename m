From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [RFC] GIT Repository Annotation Convention
Date: Fri, 09 Sep 2005 10:24:48 -0400
Message-ID: <43219B30.4040308@gmail.com>
References: <87ll2aib73.fsf@gmail.com> <431DA8CD.9060009@gmail.com>	<432060B8.6080408@gmail.com> <7vr7bzv3r2.fsf@assigned-by-dhcp.cox.net>	<43208110.6020607@gmail.com> <7vvf1bq64t.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 09 16:27:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDjoL-0002Mt-UK
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 16:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVIIOY5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 10:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbVIIOY5
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 10:24:57 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:28631 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964782AbVIIOY4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2005 10:24:56 -0400
Received: by wproxy.gmail.com with SMTP id 57so1512777wri
        for <git@vger.kernel.org>; Fri, 09 Sep 2005 07:24:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=E8AFnZjSZuI3C4G6D9MavskBeF1e4/MDaroMuYUBdOXuxEy/JKY8IJvYmidVdQpewh9aNI3xmKJoCaPC3zxLhnygbWaDHRz++PC4DZQW7lX1rktDXXc+3yKcMGcYNodtWkBVRN9owFuz2dnin0vGENLt5G5ThKiSheEssr9ak8A=
Received: by 10.54.5.41 with SMTP id 41mr340695wre;
        Fri, 09 Sep 2005 07:24:53 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 8sm1198801wrl.2005.09.09.07.24.53;
        Fri, 09 Sep 2005 07:24:53 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: git Mailing List <git@vger.kernel.org>
In-Reply-To: <7vvf1bq64t.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8239>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>>Junio C Hamano wrote:
>>>A Large Angry SCM <gitzilla@gmail.com> writes:
>>>
>>>>Naming and Directory Structure
>>>>------------------------------
>>>>Annotations are named by appending ".txt" to the basename of the
>>>>repository component it describes, and by appending ".dir" to each
>>>>directory patch component leading to the repository component from
>>>>$GIT_DIR, and by prepending "annotations/" to the annotation pathname.
>>>I suspect you can do the same without .dir but only with .txt.
>>Think about a directory containing directories "foo" and "foo.txt":
> 
> And where do you see foo.txt under $GIT_DIR/ hierarchy?

Are you saying I can't name a branch "foo.txt"? Or have the following
branches?

$GIT_DIR/refs/head/WidgetSoft/Blue
$GIT_DIR/refs/head/WidgetSoft/Red
$GIT_DIR/refs/head/WidgetSoft.txt/Blue
$GIT_DIR/refs/head/WidgetSoft.txt/Red
