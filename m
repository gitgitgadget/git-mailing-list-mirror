From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Git Questions
Date: Mon, 20 Aug 2007 14:06:19 +0100
Message-ID: <e1dab3980708200606l4e26ce8bx45c31eee81f967af@mail.gmail.com>
References: <1187603749.11595.10.camel@tom-desktop>
	 <87bqd2bgb0.fsf@morpheus.local>
	 <1187612156.11595.17.camel@tom-desktop>
	 <vpqlkc6nz8c.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Tom Schinckel" <gunny01@gmail.com>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 15:06:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN6xc-0001rT-5j
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 15:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbXHTNGV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 09:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbXHTNGV
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 09:06:21 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:39655 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbXHTNGU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 09:06:20 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1229318wxd
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 06:06:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AsOEd1FMQMWhlall3mk+Nlxc6V1ykfMjUDyT0DCXd39A/L5WHfV19K5ed9t0dhu8alG1GNZufWzZv8VXRwnNkBIrP6FUqtBCI3N8hyKhDqcIIlxuuVNcwlfIULqX00ef2BI39WNPD4bhYpAI7boUWivzDDu/MHZ8Nl5/sHlJbdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FIYlo6yzGVrEABc/KSCfI3xFh3cwFbAjWbgQHtfgviG9Etged/4K9LzNytdfCujKaGhlXSfrRkyOC5fg5G3vOhf2jAuAPowphLFNmn7dRt/nORSonNcK97iPKDBllsGcW0iLXsYiyeur9iYaE+RtIP1AWhAYjs3Pxq0pqnJ2AVg=
Received: by 10.70.14.20 with SMTP id 20mr10596599wxn.1187615179401;
        Mon, 20 Aug 2007 06:06:19 -0700 (PDT)
Received: by 10.70.26.12 with HTTP; Mon, 20 Aug 2007 06:06:19 -0700 (PDT)
In-Reply-To: <vpqlkc6nz8c.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56214>

On 8/20/07, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> OK. AAUI, you're abusing git as a backup system.

Just as a point, I think a better word is "archive system". (Backups
are more for replicating current state in the event of a system failure.
Clearly _if_ you're working on a well defined project, careful repository
management is a good idea. (One of the key things you lose
from automatic commits is the ability to reliably bisect stuff.)

However, not all the work one does on a computer is so
focussed and well-demarcated, so in other cases keeping
a history so you can, eg, look at what you're research codebase looked
like when you generated the results you pasted into a paper
on July 12 2005 is a useful ability, even if that sort of "looseness"
wouldn't be appropriate in "product" based development.

The nice thing about git is that it's so efficient at the low levels
it can be used for both "proper" SCM and archival storage.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
