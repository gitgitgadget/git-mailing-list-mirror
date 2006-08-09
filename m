From: Alan Larkin <nobrow@eircom.net>
Subject: Re: setting up a git repo on apache
Date: Wed, 09 Aug 2006 18:02:41 +0100
Message-ID: <44DA1531.3@eircom.net>
References: <44DA060B.2050601@eircom.net> <20060809164305.GA7841@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 09 19:03:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GArSi-0004sl-4W
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 19:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWHIRCn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 13:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWHIRCn
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 13:02:43 -0400
Received: from mail14.svc.cra.dublin.eircom.net ([159.134.118.30]:47911 "HELO
	mail14.svc.cra.dublin.eircom.net") by vger.kernel.org with SMTP
	id S1751258AbWHIRCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 13:02:42 -0400
Received: (qmail 68250 messnum 5469295 invoked from network[193.1.133.115/affront.ucd.ie]); 9 Aug 2006 17:02:41 -0000
Received: from affront.ucd.ie (HELO ?193.1.133.115?) (193.1.133.115)
  by mail14.svc.cra.dublin.eircom.net (qp 68250) with SMTP; 9 Aug 2006 17:02:41 -0000
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
To: git@vger.kernel.org
In-Reply-To: <20060809164305.GA7841@nospam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25129>

Rutger Nijlunsing wrote:
> On Wed, Aug 09, 2006 at 04:58:03PM +0100, Alan Larkin wrote:
>> New user ... Hi.
>>
>> I realise that this is really an apache question, but Im not getting any
>> help from their mailing lists and figure that there must be someone here
>> whos done this.
>>
>> Can someone please help me get a GIT repo running on Apache 2.
>> Specifically my problem is with DAV.
>>
>> $ git push http://localhost:/webdav/git/myproj master
>> Error: no DAV locking support on remote repo
> 
> This 'localhost:' is a typo, right?
> 
> (just to be sure)
> 
> 

Um ... it wasnt actually. I was copying this line from "A git core
tutorial for developers":

$ git push <public-host>:/path/to/my-git.git master

Although I did think it curious enough to try it with and without the
colon (it is the colon youre questioning right?).
