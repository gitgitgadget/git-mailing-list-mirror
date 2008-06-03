From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 3 Jun 2008 09:32:02 +0200
Message-ID: <200806030932.03051.jnareb@gmail.com>
References: <200806030314.03252.jnareb@gmail.com> <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 09:33:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3R0z-0000G0-Kv
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 09:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbYFCHcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 03:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYFCHcN
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 03:32:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:59241 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbYFCHcM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 03:32:12 -0400
Received: by ug-out-1314.google.com with SMTP id h2so34882ugf.16
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 00:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=iuFHFSdDCy7+rIhTEjqzkvMX8+ET0kyFmU2ezhHqhzs=;
        b=A3y6WgSztqO0DTP3kQLaxUB8T0sRUoAa5WY5NxWJGa038VefsP+OSUzj1DLI+wF+9U
         E0Z6W6e7vzcwJQ/llSZk6YXaIjl6mQsFKmie3nDoU6ZMIgwOyY1mnK21FXwUQiCxeRn9
         f1pHaiZOz0oi6rcK+x32wZSCmaO1EJq5LzjbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=monS5T9VYWIWw1YNe2CphxqcqQRQKstyqhkJah1fJcDh7FhQP5twpoTPtdVj/kNFeR
         uPOiZlpRtpWN6L5zF4JNy1YauVEW0n1Qvdjs2AkY7yYSrArXSjyLOJArP68snjHJigla
         bzJXupP2dQyE7hFR5Eh6zUHDlivCkHdvVyhuk=
Received: by 10.67.105.12 with SMTP id h12mr305934ugm.45.1212478327928;
        Tue, 03 Jun 2008 00:32:07 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.244.52])
        by mx.google.com with ESMTPS id n34sm2442084ugc.1.2008.06.03.00.32.05
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 00:32:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83624>

On Tue, 3 June 2008, Linus Torvalds wrote:
> 
> On Tue, 3 Jun 2008, Jakub Narebski wrote:
>>
>> I think that octopus merge (merge with more than two parents/legs) is 
>> feature which is unique to git (isn't it?).  Do you remember perhaps 
>> why it was introduced?
> 
> Well, mainly because the data structures supported the notion naturally.
> 
> Once you have 0, 1 or 2 parents, the logical progression is "many". 

Well, it of course depends on design.  For example Mercurial (from what
I have read in the documentation) has fixed width (two element) parents
array in revflog structure.  Commit can have no parents (root commit),
one parent, or two parents.  There is no place (again: AFAIK) for
octopus[*1*] merge.

Footnotes:
==========
[*1*] I assume that this kind of merge is called 'octopus' because it
      has more than two "legs" (parents), and not for example because
      first such merge had 8 parents?
-- 
Jakub Narebski
Poland
