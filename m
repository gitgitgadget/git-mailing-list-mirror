From: David Brown <git@davidb.org>
Subject: Re: State of Perforce importing.
Date: Wed, 19 Sep 2007 11:25:45 -0700
Message-ID: <20070919182545.GA2266@old.davidb.org>
References: <20070917193027.GA24282@old.davidb.org> <20070918233749.GA19533@old.davidb.org> <200709190819.12188.simon@lst.de> <20070919171243.GA23902@old.davidb.org> <3f4fd2640709191123j64b53878vc96d785c13c3bca2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Simon Hausmann <simon@lst.de>, Git <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 20:43:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY4FF-0003EV-70
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 20:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbXISSZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 14:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754174AbXISSZs
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 14:25:48 -0400
Received: from mail.davidb.org ([66.93.32.219]:39353 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbXISSZr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 14:25:47 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IY4F7-0000bo-LN; Wed, 19 Sep 2007 11:25:45 -0700
Mail-Followup-To: Reece Dunn <msclrhd@googlemail.com>,
	Simon Hausmann <simon@lst.de>, Git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3f4fd2640709191123j64b53878vc96d785c13c3bca2@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58720>

On Wed, Sep 19, 2007 at 07:23:41PM +0100, Reece Dunn wrote:

>> I think it would be sufficient to check the first or second character for
>> an 'x'.  I'll make a change and give it a try later today.
>
>These are the old file types. If you read the output of `p4 help
>filetypes`, the new way of specifying this is with file type
>modifiers. Therefore, you also have things like text+x.

So my patch I just sent may not be sufficient.  Thing is, we set the file
type as 'text+x' and it comes back as xtext, so I'm not sure if P4 ever
gives out text+x or if that is just available as a new way of specifying
them.

David
