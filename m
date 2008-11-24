From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Stgit and refresh-temp
Date: Mon, 24 Nov 2008 09:11:51 -0500
Message-ID: <9e4733910811240611x605b539am6a659ab29437035@mail.gmail.com>
References: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com>
	 <20081107054419.GA27146@diana.vm.bytemark.co.uk>
	 <b0943d9e0811110959t4eb236bvd648fbca5e482911@mail.gmail.com>
	 <20081112080103.GA25454@diana.vm.bytemark.co.uk>
	 <b0943d9e0811120202wae88381j9fbc9f919b49dce5@mail.gmail.com>
	 <20081112101439.GA27469@diana.vm.bytemark.co.uk>
	 <b0943d9e0811231320s804eff0k5aecbac84cb2ffe7@mail.gmail.com>
	 <20081124111635.GA31986@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 15:13:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4cBZ-0008TM-OH
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 15:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbYKXOLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 09:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbYKXOLx
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 09:11:53 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:29760 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbYKXOLw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 09:11:52 -0500
Received: by qw-out-2122.google.com with SMTP id 3so352526qwe.37
        for <git@vger.kernel.org>; Mon, 24 Nov 2008 06:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=g20mwv6YqOeppxUaZgr+cwCt6Rx5yZUauCSNlC7DXx4=;
        b=ky9mSnt9IEUeQkjzYvR7e0gHIX0vkwSJC+hdDRUF85nLE9BNMreyt5BvOpVz5tnPT4
         0y/iQiqmGsvstPjOAr5FXtIyqpxqwkPnj5Ol2a2U+J/1D5/1LJyyi7VH50It4jWviV4Z
         rg+yTDVwjdymeQvQSuFwpj8f2UMAhvXdxyXtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qkVqSODX/5E9EJm+AzIsLexHhfoap+hjl9mb8yBOyh2zDBSkE9z6twwwYTW1QP1wpM
         UusCrXz7jj1qWVzjf25/4C2tY4WGhHN86mzxHTAzcaHNtNI334ri2fFXDOypajJ/yIS3
         T6tBeOUBpv4tQiNhNCFZ2Kqj+CCc8dDpbNo1I=
Received: by 10.214.115.12 with SMTP id n12mr2037056qac.52.1227535911570;
        Mon, 24 Nov 2008 06:11:51 -0800 (PST)
Received: by 10.214.181.3 with HTTP; Mon, 24 Nov 2008 06:11:51 -0800 (PST)
In-Reply-To: <20081124111635.GA31986@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101605>

A useful future enhancement would be to adjust patches that insert
adjacent areas so that they can pass each other in a pop/pop
operation. The most common case of this being appends to end of file.

This would be a form of automatic conflict resolution. The pending
patch would be automatically corrected to resolve the adjacent insert
conflict.  You might want a prompt asking if this was ok andt then
remember the answer so that question is not asked repeatedly.

It's a mechanism to say that multiple insertions at point X in the
original file don't matter in their order of insertion.

-- 
Jon Smirl
jonsmirl@gmail.com
