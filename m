From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 02 Sep 2007 10:57:03 +0100
Message-ID: <46DA88EF.7080103@zytor.com>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>	<46DA5F33.2020005@zytor.com> <85odgltrtj.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 11:59:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRmER-000216-NB
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 11:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755866AbXIBJ6U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 05:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755854AbXIBJ6U
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 05:58:20 -0400
Received: from terminus.zytor.com ([198.137.202.10]:43333 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794AbXIBJ6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 05:58:19 -0400
Received: from titan.hos.anvin.org ([217.206.93.210])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l829vTNx019382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 2 Sep 2007 02:57:34 -0700
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <85odgltrtj.fsf@lola.goethe.zz>
X-Virus-Scanned: ClamAV 0.88.7/4131/Sun Sep  2 01:47:51 2007 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57311>

David Kastrup wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> Junio C Hamano wrote:
>>> * For people who need to import from Perforce, a front-end for
>>>   fast-import is in contrib/fast-import/.
>>>
>> There seems to be an issue with this and RPMS.
>>
>> In particular, there is no longer a git-p4 RPMS, which prevents git
>> from getting upgraded at all by yum.
>>
>> Anyone who knows yum well enough to explain what needs to be done so
>> that yum knows this is obsolete?
> 
> Probably a matter of the correct spec file.  In auctex.spec, we have
> 

 From the looks of it, there is still a git-p4, it just moved to contrib 
and uses fast-import, so removing its rpm package was probably broken in 
the first place.

"make rpm" is also broken for "dirty" builds, which is bad for testing.

	-hpa
