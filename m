From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t7610: cd inside subshell instead of around
Date: Tue, 24 Aug 2010 00:03:35 -0500
Message-ID: <20100824050335.GD20037@burratino>
References: <1282617444-641-1-git-send-email-brian@gernhardtsoftware.com>
 <20100824030524.GF17406@burratino>
 <432D99EA-303B-4201-9B07-7694800B4580@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 07:05:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnlhL-000508-CR
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 07:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847Ab0HXFFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 01:05:17 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33972 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab0HXFFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 01:05:16 -0400
Received: by gwj17 with SMTP id 17so2404849gwj.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 22:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pu2Ei4DV3+Ht4lGHDmE7bJxqh+Bb3TXgE4SsXG2ir7w=;
        b=wG/FKsjynFNK/RRNgT6qgARA9CKF571B4U53ZMs43RL8oWHcNAtalJphD+iUXziNAh
         NA4uLnqBrJdhHb+wtf/3DY+k/zkWAa2f08SZARAgD2EGLq8n50++/A/iRRyOwkMgNYby
         gaLlaUNza8t/ykQyAf9H3V/NS2SJkTqF+w/tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=K8B6/EkY5jExbN7EqjJ/oEx3mQovB7Ao/+FTnBAyYoHmEFdjniefQMldRA7pox6IS6
         Mp5Hp+QTz7iIPk9ArlG/V0kL8RbajbA//c2nfSnB7v/dESmWBjebq6nvgMyVNlHNfQuY
         ig8GQ22p1epqI+My0knXpREo+WFJ1mF5I/ho8=
Received: by 10.100.86.4 with SMTP id j4mr6484116anb.230.1282626315657;
        Mon, 23 Aug 2010 22:05:15 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q7sm12159485anf.6.2010.08.23.22.05.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 22:05:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <432D99EA-303B-4201-9B07-7694800B4580@gernhardtsoftware.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154291>

Brian Gernhardt wrote:

> Thanks for cleaning up the rest.

Glad you liked it.  BTW I did not mean to imply your cleanup was
half-hearted or anything.  On the contrary, I was very happy with it.
