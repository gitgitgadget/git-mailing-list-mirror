From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: qgit4 and top of git tree
Date: Sun, 25 Feb 2007 19:34:42 +0000
Message-ID: <200702251934.45234.andyparkins@gmail.com>
References: <cc723f590702240803o24ca01ffxfea904bf7b11c05@mail.gmail.com> <e5bfff550702250939m14e27e21m88078aad1bb1c72a@mail.gmail.com> <cc723f590702251025h1af7922ob379f8b0dfd29cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Aneesh Kumar" <aneesh.kumar@gmail.com>,
	"Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 25 20:37:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLPBk-0008KB-4l
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 20:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbXBYThh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 14:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbXBYThh
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 14:37:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:55759 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbXBYThg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 14:37:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so650578uga
        for <git@vger.kernel.org>; Sun, 25 Feb 2007 11:37:35 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IqI7CJxt3H1FetNNsp92N55BmPO+bDAo88oUoDMzICyfPYyv8/LQ8W+drDpPkSxWFn0qHyxW3//haXKhz3qUS7F0DDxiqScs3YTX2WA+DAtLhcVkK2Rsnyr1k/3meJFg1pXYJKJ6pVTeD+ewQSjCU8eo3JiUrqYLfwa33V3kWN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RcFjAjOtD1Q69mq4gYHWnfn6ZR71Se0i+zTCLL1tANTMoYMTs3xUaPRvJhvSP30ng29+WkMc24Hfoj6XM4CshYI4bPb/HhovLuFZpaj+Qnq+yIZnFhWMZTXDsjeYaTKF1c7b/KyWKJhmINb7yonrIztMQamcR080Jfel592+Bbc=
Received: by 10.67.26.7 with SMTP id d7mr5356463ugj.1172432255081;
        Sun, 25 Feb 2007 11:37:35 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id o24sm4888212ugd.2007.02.25.11.37.32;
        Sun, 25 Feb 2007 11:37:32 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <cc723f590702251025h1af7922ob379f8b0dfd29cc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40571>

On Sunday 2007, February 25, Aneesh Kumar wrote:

> With my limitted GUI prg experience i would guess it would be set in
> qt. That width would be the fill horizontal attribute for the
> frame/canvas that carry the html object.

It is set in Qt, however it's not set by a widget size.  The text box 
holding the log is a rich text box which supports a limited subset of 
HTML.  Unfortunately it seems that despite the Qt documentation 
claiming that the width attribute for tables is supported - it isn't.

I know exactly what you're after, as it's what I wanted too, but Qt is 
ignoring it.  So the options become:
 - Write our own HTML parsing engine - yuck.
 - Wait for the next Qt and hope that the renderer has improved.

Sorry.  I'll keep trying things, and of course send a patch if I find a 
workaround.


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
