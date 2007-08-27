From: Sam Vilain <sam@vilain.net>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls?
 etc.
Date: Mon, 27 Aug 2007 22:56:54 +1200
Message-ID: <46D2ADF6.70100@vilain.net>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com>	<7v1wdqud0z.fsf@gitster.siamese.dyndns.org>	<52E107D8068148B795FB4279B6272B8E@ntdev.corp.microsoft.com>	<7vsl66svv4.fsf@gitster.siamese.dyndns.org>	<C22431BFCD8E403FA10C8E91DE8AC19A@ntdev.corp.microsoft.com>	<7vhcmmpxed.fsf@gitster.siamese.dyndns.org>	<B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com>	<46D23C48.6060904@vilain.net> <85ps19a5hm.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 12:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPcGb-00067Q-6X
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 12:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbXH0K4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 06:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753663AbXH0K4R
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 06:56:17 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:51685 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbXH0K4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 06:56:16 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id DC93421CFA2; Mon, 27 Aug 2007 22:56:14 +1200 (NZST)
Received: from [192.168.1.2] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 8332D21CF9D;
	Mon, 27 Aug 2007 22:56:09 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <85ps19a5hm.fsf@lola.goethe.zz>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56811>

David Kastrup wrote:
>> These files which store metadata would be stored in a way that is
>> "in another dimension" to the project files, despite being a part of
>> the history.  That means that all tools built to deal with regular
>> files and directories will not be able to merge the changes to the
>> attributes without special support.  I think this is broken.
>>     
>
> That presumes that a good way to merge attributes is to use a text
> file merge algorithm, complete with finding diff context lines in a
> basically unchanged order.
>   

Yes.  Is that not a reasonable assumption, in the absence of anything
more enlightened?

>> As far as file properties goes, I still like Linus' idea of making
>> these files which are accessed by treating the file as a directory
>> (eg filename.txt/ACL, filename.txt/mime-type), and that approach
>> could be represented in git well.
>>     
>
> Well, at least _some_ interesting Reiser4 idea resurfaces.
>   

That was in there too?  Man that Reiser4 manifesto read like the Naked
Lunch.

Sam.
