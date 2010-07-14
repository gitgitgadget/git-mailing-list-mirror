From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: how to delete from history some files, and commits with them?
Date: Wed, 14 Jul 2010 11:15:08 -0500
Message-ID: <20100714161508.GA2330@burratino>
References: <loom.20100714T170722-272@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tikhon Tarnavski <t.t@unixforum.org>
X-From: git-owner@vger.kernel.org Wed Jul 14 18:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ4cz-0005RA-N0
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 18:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756711Ab0GNQQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 12:16:01 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52675 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab0GNQQB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 12:16:01 -0400
Received: by ewy23 with SMTP id 23so1450800ewy.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2wAfPm+rSfAOi53hpLXSTcF5EPppt8xGMrX1DOUTnsk=;
        b=tcLInmfCsc1xF6S1rgFJHkwrf+KuyQzJaehCOO4GdLC8rfcsx5EgYcfAO4m/d3g1dl
         g+/vgZ1Pi+14p1S35rTP+44kptWPwu5ZR5zAAbJmqtA+b8zOSTwIYsEmiTDtm+v11V+F
         i273JQAY3v1em8CtRVZuJRaJ4hohUYJ76U6QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=W+ghZF1wZ+eNs2AybosdKCqvvJSIM8wGYdFsLs0lg7Se90O4EgCJlqu8lkZxmaUF++
         mC+LlZlbN76ZVQ5AMhlVJAWaqk5DwdiSnAvQNEapTboZyLBqTsWXJ0EDyvyqB/QTrsia
         hwgu1AXp4oJ5kK9tv9gOKCibsXRD/5nRaPFkM=
Received: by 10.213.105.207 with SMTP id u15mr4027803ebo.83.1279124159509;
        Wed, 14 Jul 2010 09:15:59 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v8sm58417855eeh.14.2010.07.14.09.15.57
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 09:15:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20100714T170722-272@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151003>

Tikhon Tarnavski wrote:

>               I can create two clones
> and run filter-branch in both to delete
> files. But I can't find how I may
> delete empty commits after that.

Maybe --prune-empty can help.
