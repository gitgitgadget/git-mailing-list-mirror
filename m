From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: Re: [PATCH] git-svn: shorten glob error message
Date: Fri, 22 Jan 2016 16:07:32 +0000
Message-ID: <1453478851657.1340@accesssoftek.com>
References: <1452522358-16943-1-git-send-email-vleschuk@accesssoftek.com>
 <20160113031601.GA28224@dcvr.yhbt.net> <20160114040759.GA7671@dcvr.yhbt.net>
 <xmqqvb6wjacq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Victor Leschuk <vleschuk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:07:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMeFO-0002VF-Jy
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 17:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbcAVQHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 11:07:34 -0500
Received: from mail.accesssoftek.com ([12.202.173.242]:55600 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbcAVQHc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2016 11:07:32 -0500
Received: from vm-mail2k13.accesssoftek.com (172.16.0.242) by
 vm-mail2k13.accesssoftek.com (172.16.0.242) with Microsoft SMTP Server (TLS)
 id 15.0.1130.7; Fri, 22 Jan 2016 08:07:32 -0800
Received: from vm-mail2k13.accesssoftek.com ([fe80::dcaa:287c:7b4f:2280]) by
 vm-mail2k13.accesssoftek.com ([fe80::dcaa:287c:7b4f:2280%12]) with mapi id
 15.00.1130.005; Fri, 22 Jan 2016 08:07:32 -0800
Thread-Topic: [PATCH] git-svn: shorten glob error message
Thread-Index: AdFO+GHqrSN3NesxSJireobm7yEHmAGNoa2A
In-Reply-To: <xmqqvb6wjacq.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
x-ms-exchange-imapappendstamp: vm-mail2k13.accesssoftek.com (15.00.1130.005)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [93.80.35.229]
Content-ID: <D3AAA3C535803349A5923C9C68479D9F@accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284557>

Hello all,

On 01/14/2016 09:15 PM, Junio C Hamano wrote:
> Eric Wong <normalperson@yhbt.net> writes:
>
>> Error messages should attempt to fit within the confines of
>> an 80-column terminal to avoid compatibility and accessibility
>> problems.  Furthermore the word "directories" can be misleading
>> when used in the context of git refnames.
>>
>> Signed-off-by: Eric Wong <normalperson@yhbt.net>
>> ---
>>    Eric Wong <normalperson@yhbt.net> wrote:
>>    > I also noticed the "Only one set of wildcard directories" error
>>    > message is unnecessary long and "wildcard directories" should
>>    > probably be shortened to "wildcards" to avoid wrapping in a terminal.
>>    > That will probably be a separate patch for me.
>>
>>    There's likely more instances of this in git-svn, but I figured
>>    we'll get this one fixed, first.
>>
>>    Also pushed to bogomips.org/git-svn.git
>>    (commit dc6aa7e61e9d33856f54d63b7acb518383420373)
>>    along with Victor's patch.
> Thanks.
>
> I am not sure if it is a good idea to show */*/* as an example in
> the message (that is an anti-example of 'one set of wildcard' by
> having three stars, isn't it?), but that is not a new issue this
> change introduces.

I agree, this should be changed, however I think this should be done in 
separate patch.

Do we have any questions left open before this could be merged into main 
git repo?

--
Victor
