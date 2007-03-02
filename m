From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Memory overrun in http-push.c
Date: Fri, 2 Mar 2007 15:23:35 +0000
Message-ID: <200703021523.37010.andyparkins@gmail.com>
References: <20070228151516.GC57456@codelabs.ru> <20070301120042.GD63606@codelabs.ru> <es9cnt$egh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 16:23:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN9bk-00023s-U9
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 16:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992511AbXCBPXm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 10:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992512AbXCBPXm
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 10:23:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:50912 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992511AbXCBPXl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 10:23:41 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1319424nfa
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 07:23:40 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jBdmqXZhNA8NjGaoB+kD6KQGBYbOr31VZgBEUvhlLXwygq4gb9qYjqCngH+WeZQgjFPceXChgNiKy/gp0D4Gt/nPDHGmwsHYvfRvoYfjywRvUan/ics8n2ZU4KyLIWwadRulMm/BJBf+rkLr22OBqkQPlX27ff0TixcNmWxcnD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SCU7jDYsmD4RDA611HG2KXA8WXift3sJ2lrR2STd8cmNadNIuhaAvsx1DzQS+3lp88m8n1oKoQB352RHTMHrnhpjrPK7WeNApcW+1pAH0/2UJHWaM5NaNCPvMllQoVBuF1fKcrL7ISslo6pfRnGeBJo5fx4usEbJl9S0KFmTTC4=
Received: by 10.49.93.4 with SMTP id v4mr7902601nfl.1172849020347;
        Fri, 02 Mar 2007 07:23:40 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id y24sm12520054nfb.2007.03.02.07.23.37;
        Fri, 02 Mar 2007 07:23:38 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <es9cnt$egh$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41217>

On Friday 2007 March 02 14:38, Jakub Narebski wrote:

> First, keyword expansion on checkout (CVS-like) is an abomination;
> the proper way is to do it on _build_ time, like git and Linux kernel

What about my SVG example?  There is no build time, the file is the file.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
