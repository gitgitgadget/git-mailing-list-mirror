From: "Leif Arne Storset" <lstorset@opera.com>
Subject: Re: [PATCH] Documentation/config.txt: Move GIT_NOTES_REWRITE_REF to
 notes.rewriteRef
Date: Wed, 05 May 2010 16:15:12 +0200
Organization: Opera Software
Message-ID: <op.vb8kjmmktmo5g6@nynorsk>
References: <1273066516-24469-1-git-send-email-lstorset@opera.com>
 <201005051600.03446.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 05 16:17:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9fPt-0001Dl-Ic
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 16:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760268Ab0EEORa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 10:17:30 -0400
Received: from smtp.opera.com ([213.236.208.81]:40477 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760161Ab0EEOR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 10:17:29 -0400
Received: from nynorsk (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o45EGYDf027615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 5 May 2010 14:16:34 GMT
In-Reply-To: <201005051600.03446.trast@student.ethz.ch>
User-Agent: Opera Mail/10.53 (Linux)
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146397>

Thomas Rast <trast@student.ethz.ch> skreiv Wed, 05 May 2010 16:00:03 +0200

> Leif Arne Storset wrote:
>> Was notes.rewrite. The environment variable refers to globs and refs,  
>> which are only mentioned by notes.rewriteRef; notes.rewrite is boolean.
>>
>> Signed-off-by: Leif Arne Storset <lstorset@opera.com>
>> ---
>> This should be a trivial fix.
>
> ACK and thanks for spotting this.  Putting it in the wrong place was
> my fault.
>
> I found the commit message confusing, though (my first thought was "we
> have a notes.rewrite configuration variable?"), and you also have a

Yeah, I misread it as notes.rewrite.

> way too long line there.  How about
>
>   Documentation/config.txt: GIT_NOTES_REWRITE_REF overrides  
> notes.rewriteRef
>
>   The documentation erroneously mentions the GIT_NOTES_REWRITE_REF
>   override in the description of notes.rewrite.<command>.  Move it
>   under notes.rewriteRef where it belongs.

Thanks, looks good. I suppose I should file a PATCH v2 now, it'll be along  
in a minute.

-- 
Leif Arne Storset
Core Technology Developer, Opera Software
Oslo, Norway
