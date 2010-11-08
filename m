From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: Add "First parent" checkbox
Date: Mon, 8 Nov 2010 13:48:17 -0600
Message-ID: <20101108194817.GC6348@burratino>
References: <20101108172421.GB3619@burratino>
 <1jrnlcv.1hnnh8x1sh3ydiM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Mon Nov 08 20:49:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFXiR-0006xp-O4
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 20:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695Ab0KHTse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 14:48:34 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65116 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab0KHTsd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 14:48:33 -0500
Received: by fxm16 with SMTP id 16so4337754fxm.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 11:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=n0led4PkFESVoHAHLoNp1IvOD5DqddeNuvTCC+ThAhc=;
        b=R0qSMXgVGX6rY6ORYa3Xe6DYjvO83eURbsvA7szuCfi5ambQsvaAXCab7zStxatcM1
         Z/BdTLIfqaRiWdAODms6DAI3XMFy+eRUp2JeFjzEF7TqmXbT/Fg0EepuARlwfHMHblSi
         v18O0FqnzJJFTOAAtA1CpK8mGlez1ohJiPfnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WlsAkgqlJAYKGpbHh76ta0jxhx7M3Q6YxwVgyHBFzaSuJYyYNTzIoMqc+6dcjdolhr
         cRxmYzB3H9I0fhZ0AO3Bgb4yfai67g+4rodey7kke4BZr9I0Er6E/QR3YBFzinvv+k8a
         J2ps9pTFYrTgL7tP+H9x2JGgsfDZJ6Ajg4edE=
Received: by 10.223.83.144 with SMTP id f16mr4150578fal.118.1289245712363;
        Mon, 08 Nov 2010 11:48:32 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id z25sm182249fam.42.2010.11.08.11.48.30
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 11:48:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1jrnlcv.1hnnh8x1sh3ydiM%lists@haller-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160976>

Stefan Haller wrote:
>> Stefan Haller wrote:

>>> I realize this conflicts with Thomas Rast's recent patch to
>>> add a word-diff dropdown box; things are fighting for space
>>> in the diff pane header...
[...]
> Matthieu made the suggestion of "line-wrapping" the widgets in the diff
> pane header if it becomes too narrow.  I guess this could work; I don't
> know enough Tcl/Tk to be able to try it out though.

Hmm.  I don't like where this method tends in the limit.

Maybe we need a notion of a "diff view", for setting up various
diff-tree options (word diff, whitespace options, context lines,
patience, diffstat, first-parent)?  The diff pane could then provide a
drop-down box for diff views already set up.
