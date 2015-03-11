From: Mike Hommey <mh@glandium.org>
Subject: Re: git commit --amend safety check?
Date: Wed, 11 Mar 2015 15:33:35 +0900
Message-ID: <20150311063335.GA20713@glandium.org>
References: <CAJo=hJuwdOzNZSVBRAPDz97Gdoi6JWvYxE0ufY+Hd9K8jjCqfA@mail.gmail.com>
 <xmqq8uf46ru8.fsf@gitster.dls.corp.google.com>
 <CAJo=hJtxeZGyP=VxLSdDzoMOtVZTFNsNTqPpNUTXUOBDZKzY9Q@mail.gmail.com>
 <CAPc5daVMec1okdBW3Wo_gEr7W3FwRwmH5pmiiMaAgGoN7MGa_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 09:39:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVcAv-0005km-KP
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 09:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbbCKIjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 04:39:25 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:43678 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbbCKIjX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 04:39:23 -0400
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YVaD1-0005Rt-FB; Wed, 11 Mar 2015 15:33:35 +0900
Content-Disposition: inline
In-Reply-To: <CAPc5daVMec1okdBW3Wo_gEr7W3FwRwmH5pmiiMaAgGoN7MGa_A@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265317>

On Tue, Mar 10, 2015 at 11:18:45PM -0700, Junio C Hamano wrote:
> One thing we already do is to give an extra "Author: " line in the
> comment when the user edits the log message, so that it is clear
> that what is being edited is not their own work but hers. We obviously
> can add the extra warning, when the is_ancestor() thing triggers, to
> say YOU ARE REWRITING PUBLISHED HISTORY in blinking red
> bold letters there.
> 
> But the symptom indicates that they are not reading these warning
> comment.

Maybe they would if the warnings were a big paragraph *before* the
commit message (but brains are easily trained to recognize patterns and
skip them, so that would need to be done for very specific warnings,
not for everything that's printed in a git commit editor).

Mike
