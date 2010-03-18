From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 18:17:48 -0400
Message-ID: <4BA2A68C.1040708@gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 23:18:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsO2X-0000Go-0a
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 23:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761Ab0CRWR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 18:17:58 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58869 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab0CRWRy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 18:17:54 -0400
Received: by gyg8 with SMTP id 8so1245314gyg.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iXUJ/oAzkZ+8KsB+/0awnPrP8+QvmhkZDLCjaKhHj3g=;
        b=qC3w5TeAJvXQck7kwZlg6XVlBlHxNEoBnsSNtJRN8yj2aMzwZFsBAbGtWz8yIGxw4/
         LRTXSQOIeubVzG4GDNxnfHnF3fNfT0m9wkdghdd0uz2PJ6DN87jQ4eYswyH/A9Ku8LYk
         uACiQIUNZTDzvnsUJ5Crl0LGrs4IWxzT5VokA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=Xx02fgb/idYk03/XVe3uvtBIPLow7rdggWyh36g+6nL5VQorcep9KAY9Lm0raucG19
         A3hfGFaL1rxWneBYf0HkEcOcAsXbWaveumVM6zqZ7yFItDsEjI217aOsvLya6lEnIhqt
         We85EhDEr4EJP39FDAugxMX1fwPLsTQZunwTI=
Received: by 10.100.29.30 with SMTP id c30mr5182017anc.148.1268950673203;
        Thu, 18 Mar 2010 15:17:53 -0700 (PDT)
Received: from [10.0.0.6] (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 4sm111901ywd.43.2010.03.18.15.17.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Mar 2010 15:17:52 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142530>

Michael Witten wrote:
> Short Version:
> -------------
> 
> 
> Rather than use a (name,email) pair to identify people, let's use
> a (uuid,name,email) triplet.
> 
> The uuid can be any piece of information that a user of git determines
> to be reasonably unique across space and time and that is intended to
> be used by that user virtually forever (at least within a project's
> history).
> 
> For instance, the uuid could be an OSF DCE 1.1 UUID or the SHA-1 of
> some easily remembered, already reasonably unique information.
> 
> This could really help keep identifications clean, and it is rather
> straightforward and possibly quite efficient.
> 
> 
> Long Version:
> ------------

[Much text deleted]

The formatting of the information in the author & committer fields are a 
_social_ convention (with a little help from the tools).You can actually 
use this proposed "feature" now for your own commits by appending the 
UUID string to you name config setting, environment variable and/or GCOS 
field today and everything will work. You can even make it a requirement 
for projects that you control. But don't expect all other projects to do 
so also as they may not care.
