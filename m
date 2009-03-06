From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: setting up tracking on push
Date: Fri, 6 Mar 2009 10:43:17 -0500
Message-ID: <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
	 <76718490903052049k217e9c12gb7881f8904fdd9d@mail.gmail.com>
	 <alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de>
	 <buoy6vi297q.fsf@dhlpc061.dev.necel.com>
	 <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: miles@gnu.org, Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: "Jeremy O'Brien" <obrien654j@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 16:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfcEL-0003Go-RC
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 16:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbZCFPnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 10:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754168AbZCFPnU
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 10:43:20 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:3600 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbZCFPnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 10:43:19 -0500
Received: by rv-out-0506.google.com with SMTP id g37so552397rvb.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 07:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KWIkwVqxv9wRrloieSWi1VVgAvoU7NSnRSAu7UkWp1M=;
        b=fCIAGL2haP25m1cCeF+q64oO+5avY7XzCpuHvisidbzB2v6hM5ENj2uo7HFC5LDgBj
         qokbf326qSyavMlErv49y4y4GuZKEtC7XmeX1cGvbZ+bMv5I0zRqXhsnddjGCMIJPY0N
         HEZy0gUXYLnC0wTqUf8FHCNfCkkqmijQRUceE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XgMee4yhL+GfMa7ToeMk07g6a3OROYCmvCHu/X42n3QZVq52ER7Pmkiwf9FOsBwkNH
         RwBY+JJp7NhQttTpGIsu0uQ9JHCXs4FvevQoERJheDRO6Y9z8CnDI2Ga1laiEaNij5hz
         wnMqKRpWCmNbNYg0FCtEPJ8J6o8Ng2Zq8Ltx4=
Received: by 10.141.176.6 with SMTP id d6mr1333550rvp.233.1236354197870; Fri, 
	06 Mar 2009 07:43:17 -0800 (PST)
In-Reply-To: <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112452>

On Fri, Mar 6, 2009 at 9:15 AM, Jeremy O'Brien <obrien654j@gmail.com> wrote:
> Miles Bader <miles@gnu.org> wrote:
>
>> Alternatively, maybe a "git track [REMOTE [BRANCH]]" command that simply
>> adds makes adding the appropriate config magic more convenient ?
>>
>> I dunno what the arg syntax would look like in the general case;
>> I almost always want to use the current branch, and track an identically
>> named branch in the origin remote though...

I don't think we need a new command, but it would probably fit into git remote

$ git remote track <remote> [<branch>]

j.
