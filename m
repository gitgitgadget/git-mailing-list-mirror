From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/7] fast-import: Allow cat requests at arbitrary points
 in stream
Date: Tue, 12 Oct 2010 17:50:16 -0500
Message-ID: <20101012225016.GE15587@burratino>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-5-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 00:53:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5nj4-0005z6-Rj
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 00:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091Ab0JLWxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 18:53:38 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64117 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab0JLWxh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 18:53:37 -0400
Received: by qwa26 with SMTP id 26so686096qwa.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 15:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QKQe2IgXQMOI+yS9d1h7LGpD1UHraL1Z7r7lExHIJA4=;
        b=CONHmr6hOLmXL4+N3iAoAhrEtxq7GWsBXzRXcyB1M1nni+Ww5648lqVQx1VDkf5Bai
         f41kVN2g+yxXPZFriCV4hPWOfManZmo1F/DEUDkAvF1Wt8Ot2ttzP9VJKCjXv03aqg31
         lujcsSh432s6WaePHGlWQqyFQg6Bfi0hSy4DE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iUmyLhZ1bBpzpN4nKODcghQs1I/EWSc0LxZrIlvswQnT2uYiWq9i11QKTOO3lvgKt0
         Q7WjeMaY0/8ELnpiZzqxXqPL7u92iWFhANVukmm/t1mZhy4c9OP+UD/PA4iUEwsFGdpZ
         JHYKNGutWL/by/etblXrN9QDCRIaSBk5GcDIA=
Received: by 10.229.219.80 with SMTP id ht16mr6832559qcb.53.1286924016686;
        Tue, 12 Oct 2010 15:53:36 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id s34sm6469796qcp.32.2010.10.12.15.53.35
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 15:53:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286891424-2067-5-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158890>

David Barr wrote:

> Rather than planning in advance and saving up a bunch of objects
> before a "commit" command, frontends might want to wait until the
> middle of a commit and request objects then.

Not needed for svn-fe3, is it?

But I do like it.  (Obviously, I'm biased.)
