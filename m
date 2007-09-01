From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: performance on repack
Date: Sat, 1 Sep 2007 17:54:31 -0400
Message-ID: <9e4733910709011454w630c53ecj67d7980838b729c@mail.gmail.com>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
	 <20070812103338.GA7763@auto.tuwien.ac.at>
	 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
	 <20070814031236.GC27913@spearce.org>
	 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
	 <20070815053231.GJ27913@spearce.org>
	 <alpine.LFD.0.999.0708151500510.5415@xanadu.home>
	 <alpine.LFD.0.999.0708300005110.16727@xanadu.home>
	 <alpine.LFD.0.999.0708300033540.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Martin Koegler" <mkoegler@auto.tuwien.ac.at>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Sep 01 23:54:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRavN-0008KU-O8
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 23:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251AbXIAVyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 17:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757151AbXIAVyd
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 17:54:33 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:62676 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756976AbXIAVyc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 17:54:32 -0400
Received: by rv-out-0910.google.com with SMTP id k20so663908rvb
        for <git@vger.kernel.org>; Sat, 01 Sep 2007 14:54:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iIb4Zj6fXcNiQ9ts9B/ZVzWfze6BikRBcVOKRNn1lbq+bdYDe/79DxtezHpL5jKmGs8mJDVKufRhcGxM5/tTiv4p2hRzYON9O/x3krJb2a1j2f2T4ADWbDynVaPEhn6kOLpM9CFA57/1ae3jN3tNzGOJna89j+ZTJl0iFsZPAOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iAReF0akdVIpfazlswbOyAIZxIZt8OrO3IY5z9nBw4LFAeo0TNjZO4Lrk2xvh1MT6LeY8nIZ3Xa+3IT9huBOEYixhY9HAL4xqLvhFS8d8A59rExZewRfwQ1iT26RFlf/bF29lxVMDufVS7WmFBs9jfqaYiOKGaWtVndEtqwPDmc=
Received: by 10.141.159.13 with SMTP id l13mr1317034rvo.1188683671559;
        Sat, 01 Sep 2007 14:54:31 -0700 (PDT)
Received: by 10.141.44.16 with HTTP; Sat, 1 Sep 2007 14:54:31 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708300033540.16727@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57282>

On 8/30/07, Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 30 Aug 2007, Nicolas Pitre wrote:
>
> > Well, here is a quick implementation of this idea for those who would
> > like to give it a try.
> [...]


Appears to be broken for a push.

jonsmirl@terra:~/mpc5200b$ git push dreamhost
updating 'refs/remotes/linus/master' using 'refs/heads/master'
  from d1caeb02b17c6bc215a9a40a98a1beb92dcbd310
  to   40ffbfad6bb79a99cc7627bdaca0ee22dec526f6
Generating pack...
Counting objects: 1
Done counting 3255 objects.
Result has 1997 objects.
Deltifying 398 objects...
Deltifying 398 objects...
Deltifying 398 objects...
Deltifying 398 objects...
Deltifying 398 objects...
Deltifying 398 objects...
Deltifying 398 objects...
Deltifying 398 objects...
Deltifying 398 objects...
Deltifying 398 objects...
Deltifying 398 objects...
Deltifying 398 objects...
Deltifying 398 objects...
Deltifying 398 objects...
Deltifying 398 objects...
Deltifying 398 objects...
   0% (2/398) donee
   1% (4/398) donee
  11% (47/398) done
   3% (12/398) done
   2% (8/398) donee

  12% (49/398) done
  17% (69/398) done
   1% (4/398) donee
  25% (100/398) done
  19% (77/398) donee
  23% (94/398) done
  21% (84/398) done
  25% (100/398) done
   2% (10/398) done
   1% (6/398) done
error: pack-objects died with strange error
unpack eof before pack header was fully read
ng refs/remotes/linus/master n/a (unpacker error)
error: failed to push to 'ssh://jonsmirl1@git.digispeaker.com/~/mpc5200b.git'
jonsmirl@terra:~/mpc5200b$



-- 
Jon Smirl
jonsmirl@gmail.com
