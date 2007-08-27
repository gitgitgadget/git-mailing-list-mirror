From: David Kastrup <dak@gnu.org>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls? etc.
Date: Mon, 27 Aug 2007 13:26:36 +0200
Message-ID: <86hcmltdzn.fsf@lola.quinscape.zz>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com> <7v1wdqud0z.fsf@gitster.siamese.dyndns.org> <52E107D8068148B795FB4279B6272B8E@ntdev.corp.microsoft.com> <7vsl66svv4.fsf@gitster.siamese.dyndns.org> <C22431BFCD8E403FA10C8E91DE8AC19A@ntdev.corp.microsoft.com> <7vhcmmpxed.fsf@gitster.siamese.dyndns.org> <B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com> <46D23C48.6060904@vilain.net> <85ps19a5hm.fsf@lola.goethe.zz> <46D2ADF6.70100@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 27 13:26:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPckB-0006F1-Ae
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 13:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbXH0L0v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 07:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754356AbXH0L0v
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 07:26:51 -0400
Received: from main.gmane.org ([80.91.229.2]:34317 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754631AbXH0L0v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 07:26:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IPck3-0002Ia-I2
	for git@vger.kernel.org; Mon, 27 Aug 2007 13:26:47 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 13:26:47 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 13:26:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:Z7jJBe0dl+O5Ky3zXVjpWv/fCcA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56816>

Sam Vilain <sam@vilain.net> writes:

> David Kastrup wrote:
>>> These files which store metadata would be stored in a way that is
>>> "in another dimension" to the project files, despite being a part of
>>> the history.  That means that all tools built to deal with regular
>>> files and directories will not be able to merge the changes to the
>>> attributes without special support.  I think this is broken.
>>>     
>>
>> That presumes that a good way to merge attributes is to use a text
>> file merge algorithm, complete with finding diff context lines in a
>> basically unchanged order.
>>   
>
> Yes.  Is that not a reasonable assumption, in the absence of anything
> more enlightened?

Is that a trick question?  My comment was exactly about not throwing
away the information ("This is not arbitrary text but talks about the
files in our tree.") that would make for more enlightened use.

-- 
David Kastrup
