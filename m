From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: git submodule merge madness
Date: Wed, 14 Jan 2009 15:49:27 -0800
Message-ID: <AE1922C4-0543-424B-A635-494445E17E45@develooper.com>
References: <ADC7A3B1-6756-4258-93CD-DB40C7D2793C@develooper.com> <alpine.DEB.1.00.0901142354120.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 00:50:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNFVe-0005ny-3f
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 00:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557AbZANXtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 18:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757541AbZANXta
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 18:49:30 -0500
Received: from x8.develooper.com ([216.52.237.208]:51260 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757534AbZANXta (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 18:49:30 -0500
Received: (qmail 13548 invoked from network); 14 Jan 2009 23:49:28 -0000
Received: from gw.develooper.com (HELO g5.bn.dev) (ask@mail.dev@64.81.84.140)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 14 Jan 2009 23:49:28 -0000
In-Reply-To: <alpine.DEB.1.00.0901142354120.3586@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105732>


On Jan 14, 2009, at 2:55 PM, Johannes Schindelin wrote:

>> We've (again) replaced a few directories with submodules.  Man, it's
>> madness!
>>
>> The typical problem is that we get an error trying to merge a "pre- 
>> submodule"
>> branch into master:
>>
>> 	fatal: cannot read object 894c77319a18c4d48119c2985a9275c9f5883584
>> 'some/sub/dir': It is a submodule!
>> Mark Levedahl wrote an example in July, but I don't think he got  
>> any replies:
>> http://marc.info/?l=git&m=121587851313303
>
> So.... Which Git version are you are using?  Did you test any Git  
> version
> containing the commit d5a84fb(merge-recursive: fail gracefully with
> directory/submodule conflicts)?

IIRC I tried 1.6.1 and master as of about a week ago.

I don't see d5a84fb in my repository (and google doesn't find it  
referenced anywhere when I search for "directory/submodule conflicts".


  - ask

-- 
http://develooper.com/ - http://askask.com/
