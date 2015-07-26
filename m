From: Dangling Pointer <danglingpointer@outlook.com>
Subject: FW: FeatureRequest: Build improvements for Windows
Date: Sun, 26 Jul 2015 08:45:42 +0000
Message-ID: <BAY169-W75E45600196FA9E4B9A20CA78F0@phx.gbl>
References: <BAY169-W8210AC5C69796A61AD2236A78F0@phx.gbl>,<BAY169-W30CD27F2F7606F4DF52944A78F0@phx.gbl>,<CA+P7+xpcXAck4HVFGLa4c9JquBTHaD-yZuuO4s0sAfJ50c+NxA@mail.gmail.com>,<BAY169-W84A0734CACD22511DE9B5BA78F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 10:45:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJHZ7-0000bd-4G
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 10:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693AbbGZIpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 04:45:44 -0400
Received: from bay004-omc3s1.hotmail.com ([65.54.190.139]:61280 "EHLO
	BAY004-OMC3S1.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbbGZIpm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2015 04:45:42 -0400
Received: from BAY169-W75 ([65.54.190.189]) by BAY004-OMC3S1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Sun, 26 Jul 2015 01:45:42 -0700
X-TMN: [3NeQUWAkQlEzFDnKQnQfYJ/FZvkURcXH]
X-Originating-Email: [danglingpointer@outlook.com]
Importance: Normal
In-Reply-To: <BAY169-W84A0734CACD22511DE9B5BA78F0@phx.gbl>
X-OriginalArrivalTime: 26 Jul 2015 08:45:42.0165 (UTC) FILETIME=[746A6C50:01D0C77F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274641>

Hmm, it is already happening, isn't it? There is already a support of MSVCR in git's code base. I am referring to replacing that current support of 'older' MSVCR in favor of the latest one, so to make the git's code base comparatively coherent and organized (as some/many instances of #ifdef _MSC_VER and #if define (_MSC_VER) && _MSC_VER < xxx etc. will be gone, for instance we don't need fallback for sprint or snprintf since C99 std support for those is provisioned).



> ----------------------------------------
>> From: jacob.keller@gmail.com
>> Date: Sun, 26 Jul 2015 00:15:10 -0700
>> Subject: Re: FeatureRequest: Build improvements for Windows
>> To: danglingpointer@outlook.com
>> CC: git@vger.kernel.org
>>
>> On Sat, Jul 25, 2015 at 11:23 PM, Dangling Pointer
>> <danglingpointer@outlook.com> wrote:
>>> Hello,
>>>
>>> In my understanding, the ratio between the mere consumers of git on Windows vs. people who compile git for Windows is 100,000 : 1. If there is a breaking change in the workflow of the latter set, who use Visual Studio to build git from source, I assume that is doable given a good reason, hence this post.
>>>
>>> With VS 2015, C99 support is "finally" added with some C11 features as well. See this blog: http://blogs.msdn.com/b/vcblog/archive/2015/06/19/c-11-14-17-features-in-vs-2015-rtm.aspx. One of the edition of new VS is Community edition, which is like professional edition but is free (also much superior than Express edition) and meant for open source projects. VS2015 also has the ability to target compiler for Wind-XP.
>>>
>>
>> I think the big issue is whether it has support for the various unix
>> interfaces and unix shell commands we use. MinGW/MSYS comes with
>> support for the unix interface, which I don't believe is that actually
>> supported via MSYS and I don't know if VS2015 is supported? I don't
>> think it's due to the C99 but due to need of posix interface which is
>> not normally (fully) provided by Windows.
>>
>> Regards,
>> Jake 		 	   		  