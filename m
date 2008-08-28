From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 17:05:33 -0700
Message-ID: <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu>
References: <20080826164526.GM26610@one.firstfloor.org> <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <B83CC7EA-C77E-45CA-B9C5-FC81A8C0C9A5@cs.indiana.edu> <20080827195019.GA9962@sigill.intra.peff.net> <38B725C0-40C3-496C-AAD4-4EA65E3085F5@cs.indiana.edu> <48B5BC5F.4070209@kernel.org> <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com> <7vd4jukphm.fsf@gitster.siamese.dyndns.org> <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"H. Peter Anvin" <hpa@kernel.org>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Andi Kleen <andi@firstfloor.org>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Thu Aug 28 02:07:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYV32-0000Q0-3K
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 02:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbYH1AGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 20:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbYH1AGb
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 20:06:31 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:46692 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbYH1AGa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 20:06:30 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7S05dXs029377;
	Wed, 27 Aug 2008 20:05:40 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7S05Ysn023324
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 27 Aug 2008 20:05:38 -0400
In-Reply-To: <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93994>

Oh yeah, sorry.  I neglected to mention that my problem was having the  
git- forms in scripts all over an internal network, and having no  
amazingly easy way of fixing them.  I don't know who all copied them.


On Aug 27, 2008, at 4:53 PM, Perry Wagle wrote:

>
> On Aug 27, 2008, at 4:27 PM, Junio C Hamano wrote:
>
>> Steven Rostedt <rostedt@goodmis.org> writes:
>>
>>> Yes, they are all a bunch of Nazi git fanatics, that Hitler  
>>> himself would
>>> have used the space version of git. He sent the Jews off to the
>>> concentration camps because they insisted on using the dashes.
>>>
>>> There, we have a Hitler reference.
>>>
>>> CAN WE PLEASE LET THIS THREAD DIE!
>>
>> Yeah, I second this.
>>
>> The primary topic has already settled, and we will keep git-foo in  
>> libexec
>> even for built-ins.
>>
>> This offtopic tangent that shouldn't even have started from the  
>> beginning
>> must die now.  It outlived its usefulness even as a place for  
>> people to
>> vent.
>
> I suggested that git<DASH><TAB> used to give the same 143  
> completions that git<SPACE><TAB> would now.  This meant that making  
> any arguments that the number was off-putting to newbies did not  
> apply, since you had a same number (143)  either way.  Putting stuff  
> in libexec does not change the above observation in any fashion.
>
> A response to my observation was that "not everything will show up  
> in the latter completion".  I balked at that as it distorted the  
> truth.  If this distortion would actually take place then I have a  
> real complaint.  Not a tangent.
>
> But as long as git<DASH><TAB> does the *same* thing as  
> git<SPACE><TAB>, I really do not see why you had to go break my  
> scripts on a *minor* revision for what amounts to no reason as all.
>
> Shells *hash* the PATH, so there is no "linear list" issue, and you  
> have the *same* behavior for <TAB> completion both ways.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
