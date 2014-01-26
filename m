From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: [PATCH 1/2] create HTML for http-protocol.txt
Date: Sun, 26 Jan 2014 14:01:05 +0100 (CET)
Message-ID: <1512575333.1102049.1390741265687.JavaMail.ngmail@webmail13.arcor-online.net>
References: <251995526.1102678.1390740898917.JavaMail.ngmail@webmail18.arcor-online.net> <735028458.1102653.1390740723616.JavaMail.ngmail@webmail18.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, spearce@spearce.org, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 26 14:01:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7PKq-0005U3-T4
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 14:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbaAZNBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 08:01:08 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:34735 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751130AbaAZNBH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jan 2014 08:01:07 -0500
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mx.arcor.de (Postfix) with ESMTP id C1C173AF297;
	Sun, 26 Jan 2014 14:01:05 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id BE47B56256D;
	Sun, 26 Jan 2014 14:01:05 +0100 (CET)
Received: from webmail13.arcor-online.net (webmail13.arcor-online.net [151.189.8.66])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id A647526303;
	Sun, 26 Jan 2014 14:01:05 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-12.arcor-online.net A647526303
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1390741265; bh=m+IRY4IBSrmL2b9R8LhOCbqp+AeEM5E0+eKrdwtzmZo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=aZnFVVb1MVOn8UdRRyiG6jdlUkafW7Sveda4J4bEVjfsV1VJ81Ukkpw5VJWqkM+gk
	 wSE536qnn07JL6V9OG4fMvslSsMK4sQjJEd5gTgBd2/zuzJXMFK9xhCnQL6/tltnEP
	 0vQCAIzC7EX+ftKHV9ALPrE66y6M3ovXc4DcA6Ic=
Received: from [94.217.129.144] by webmail13.arcor-online.net (151.189.8.66) with HTTP (Arcor Webmail); Sun, 26 Jan 2014 14:01:05 +0100 (CET)
In-Reply-To: <251995526.1102678.1390740898917.JavaMail.ngmail@webmail18.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.129.144
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241086>

 
please ignore this one

----- Original Nachricht ----
Von:     Thomas Ackermann <th.acker@arcor.de>
An:      git@vger.kernel.org
Datum:   26.01.2014 13:54
Betreff: [PATCH 1/2] create HTML for http-protocol.txt

> [PATCH 1/2] create HTML for http-protocol.txt
> 
> ./Documentation/technical/http-protocol.txt was missing from TECH_DOCS in
> Makefile.
> Add it and also improve HTML formatting while still retaining good
> readability of the ASCII text:
> - Use monospace font instead of italicized or roman font for machine output
> and source text
> - Use roman font for things which should be body text
> - Use double quotes consistently for "want" and "have" commands
> - Use uppercase "C" / "S" consistently for "client" / "server";
>   also use "C:" / "S:" instead of "(C)" / "(S)" for consistency and
>   to avoid having formatted "(C)" as copyright symbol in HTML
> - Use only spaces and not a combination of tabs and spaces for whitespace
> 
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/Makefile                    |   3 +-
>  Documentation/technical/http-protocol.txt | 232
> +++++++++++++++---------------
>  2 files changed, 120 insertions(+), 115 deletions(-)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 36c58fc..b19d52a 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -60,7 +60,8 @@ SP_ARTICLES += howto/maintain-git
>  API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt
> technical/api-index.txt, $(wildcard technical/api-*.txt)))
>  SP_ARTICLES += $(API_DOCS)
>  
> -TECH_DOCS = technical/index-format
> +TECH_DOCS = technical/http-protocol
> +TECH_DOCS += technical/index-format
>  TECH_DOCS += technical/pack-format
>  TECH_DOCS += technical/pack-heuristics
>  TECH_DOCS += technical/pack-protocol
> diff --git a/Documentation/technical/http-protocol.txt
> b/Documentation/technical/http-protocol.txt
> index d21d77d..7f0cf0b 100644
> --- a/Documentation/technical/http-protocol.txt
> +++ b/Documentation/technical/http-protocol.txt
> @@ -20,13 +20,13 @@ URL syntax documented by RFC 1738, so they are of the
> form:
>  
>    http://<host>:<port>/<path>?<searchpart>
>  
> -Within this documentation the placeholder $GIT_URL will stand for
> +Within this documentation the placeholder `$GIT_URL` will stand for
>  the http:// repository URL entered by the end-user.
>  
> -Servers SHOULD handle all requests to locations matching $GIT_URL, as
> +Servers SHOULD handle all requests to locations matching `$GIT_URL`, as
>  both the "smart" and "dumb" HTTP protocols used by Git operate
>  by appending additional path components onto the end of the user
> -supplied $GIT_URL string.
> +supplied `$GIT_URL` string.
>  
>  An example of a dumb client requesting for a loose object:
>  
> @@ -43,10 +43,10 @@ An example of a request to a submodule:
>    $GIT_URL:     http://example.com/git/repo.git/path/submodule.git
>    URL request: 
> http://example.com/git/repo.git/path/submodule.git/info/refs
>  
> -Clients MUST strip a trailing '/', if present, from the user supplied
> -$GIT_URL string to prevent empty path tokens ('//') from appearing
> +Clients MUST strip a trailing `/`, if present, from the user supplied
> +`$GIT_URL` string to prevent empty path tokens (`//`) from appearing
>  in any URL sent to a server.  Compatible clients MUST expand
> -'$GIT_URL/info/refs' as 'foo/info/refs' and not 'foo//info/refs'.
> +`$GIT_URL/info/refs` as `foo/info/refs` and not `foo//info/refs`.
>  
>  
>  Authentication
> @@ -103,14 +103,14 @@ Except where noted, all standard HTTP behavior SHOULD
> be assumed
>  by both client and server.  This includes (but is not necessarily
>  limited to):
>  
> -If there is no repository at $GIT_URL, or the resource pointed to by a
> -location matching $GIT_URL does not exist, the server MUST NOT respond
> -with '200 OK' response.  A server SHOULD respond with
> -'404 Not Found', '410 Gone', or any other suitable HTTP status code
> +If there is no repository at `$GIT_URL`, or the resource pointed to by a
> +location matching `$GIT_URL` does not exist, the server MUST NOT respond
> +with `200 OK` response.  A server SHOULD respond with
> +`404 Not Found`, `410 Gone`, or any other suitable HTTP status code
>  which does not imply the resource exists as requested.
>  
> -If there is a repository at $GIT_URL, but access is not currently
> -permitted, the server MUST respond with the '403 Forbidden' HTTP
> +If there is a repository at `$GIT_URL`, but access is not currently
> +permitted, the server MUST respond with the `403 Forbidden` HTTP
>  status code.
>  
>  Servers SHOULD support both HTTP 1.0 and HTTP 1.1.
> @@ -126,9 +126,9 @@ Servers MAY return ETag and/or Last-Modified headers.
>  Clients MAY revalidate cached entities by including If-Modified-Since
>  and/or If-None-Match request headers.
>  
> -Servers MAY return '304 Not Modified' if the relevant headers appear
> +Servers MAY return `304 Not Modified` if the relevant headers appear
>  in the request and the entity has not changed.  Clients MUST treat
> -'304 Not Modified' identical to '200 OK' by reusing the cached entity.
> +`304 Not Modified` identical to `200 OK` by reusing the cached entity.
>  
>  Clients MAY reuse a cached entity without revalidation if the
>  Cache-Control and/or Expires header permits caching.  Clients and
> @@ -148,7 +148,7 @@ HTTP clients that only support the "dumb" protocol MUST
> discover
>  references by making a request for the special info/refs file of
>  the repository.
>  
> -Dumb HTTP clients MUST make a GET request to $GIT_URL/info/refs,
> +Dumb HTTP clients MUST make a `GET` request to `$GIT_URL/info/refs`,
>  without any search/query parameters.
>  
>     C: GET $GIT_URL/info/refs HTTP/1.0
> @@ -161,28 +161,28 @@ without any search/query parameters.
>     S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}
>  
>  The Content-Type of the returned info/refs entity SHOULD be
> -"text/plain; charset=utf-8", but MAY be any content type.
> +`text/plain; charset=utf-8`, but MAY be any content type.
>  Clients MUST NOT attempt to validate the returned Content-Type.
>  Dumb servers MUST NOT return a return type starting with
> -"application/x-git-".
> +`application/x-git-`.
>  
>  Cache-Control headers MAY be returned to disable caching of the
>  returned entity.
>  
>  When examining the response clients SHOULD only examine the HTTP
> -status code.  Valid responses are '200 OK', or '304 Not Modified'.
> +status code.  Valid responses are `200 OK`, or `304 Not Modified`.
>  
>  The returned content is a UNIX formatted text file describing
>  each ref and its known value.  The file SHOULD be sorted by name
>  according to the C locale ordering.  The file SHOULD NOT include
> -the default ref named 'HEAD'.
> +the default ref named `HEAD`.
>  
>    info_refs   =  *( ref_record )
>    ref_record  =  any_ref / peeled_ref
>  
>    any_ref     =  obj-id HTAB refname LF
>    peeled_ref  =  obj-id HTAB refname LF
> -		 obj-id HTAB refname "^{}" LF
> +                 obj-id HTAB refname "^{}" LF
>  
>  Smart Clients
>  ~~~~~~~~~~~~~
> @@ -192,13 +192,14 @@ HTTP clients that support the "smart" protocol (or
> both the
>  a parameterized request for the info/refs file of the repository.
>  
>  The request MUST contain exactly one query parameter,
> -'service=$servicename', where $servicename MUST be the service
> +`service=$servicename`, where `$servicename` MUST be the service
>  name the client wishes to contact to complete the operation.
>  The request MUST NOT contain additional query parameters.
>  
>     C: GET $GIT_URL/info/refs?service=git-upload-pack HTTP/1.0
>  
> -   dumb server reply:
> +dumb server reply:
> +
>     S: 200 OK
>     S:
>     S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint
> @@ -206,7 +207,8 @@ The request MUST NOT contain additional query
> parameters.
>     S: 2cb58b79488a98d2721cea644875a8dd0026b115	refs/tags/v1.0
>     S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	refs/tags/v1.0^{}
>  
> -   smart server reply:
> +smart server reply:
> +
>     S: 200 OK
>     S: Content-Type: application/x-git-upload-pack-advertisement
>     S: Cache-Control: no-cache
> @@ -228,7 +230,7 @@ Smart Server Response
>  ^^^^^^^^^^^^^^^^^^^^^
>  If the server does not recognize the requested service name, or the
>  requested service name has been disabled by the server administrator,
> -the server MUST respond with the '403 Forbidden' HTTP status code.
> +the server MUST respond with the `403 Forbidden` HTTP status code.
>  
>  Otherwise, smart servers MUST respond with the smart server reply
>  format for the requested service name.
> @@ -236,46 +238,46 @@ format for the requested service name.
>  Cache-Control headers SHOULD be used to disable caching of the
>  returned entity.
>  
> -The Content-Type MUST be 'application/x-$servicename-advertisement'.
> +The Content-Type MUST be `application/x-$servicename-advertisement`.
>  Clients SHOULD fall back to the dumb protocol if another content
>  type is returned.  When falling back to the dumb protocol clients
> -SHOULD NOT make an additional request to $GIT_URL/info/refs, but
> +SHOULD NOT make an additional request to `$GIT_URL/info/refs`, but
>  instead SHOULD use the response already in hand.  Clients MUST NOT
>  continue if they do not support the dumb protocol.
>  
> -Clients MUST validate the status code is either '200 OK' or
> -'304 Not Modified'.
> +Clients MUST validate the status code is either `200 OK` or
> +`304 Not Modified`.
>  
>  Clients MUST validate the first five bytes of the response entity
> -matches the regex "^[0-9a-f]{4}#".  If this test fails, clients
> +matches the regex `^[0-9a-f]{4}#`.  If this test fails, clients
>  MUST NOT continue.
>  
>  Clients MUST parse the entire response as a sequence of pkt-line
>  records.
>  
> -Clients MUST verify the first pkt-line is "# service=$servicename".
> +Clients MUST verify the first pkt-line is `# service=$servicename`.
>  Servers MUST set $servicename to be the request parameter value.
>  Servers SHOULD include an LF at the end of this line.
>  Clients MUST ignore an LF at the end of the line.
>  
> -Servers MUST terminate the response with the magic "0000" end
> +Servers MUST terminate the response with the magic `0000` end
>  pkt-line marker.
>  
>  The returned response is a pkt-line stream describing each ref and
>  its known value.  The stream SHOULD be sorted by name according to
>  the C locale ordering.  The stream SHOULD include the default ref
> -named 'HEAD' as the first ref.  The stream MUST include capability
> +named `HEAD` as the first ref.  The stream MUST include capability
>  declarations behind a NUL on the first ref.
>  
>    smart_reply     =  PKT-LINE("# service=$servicename" LF)
> -		     ref_list
> -		     "0000"
> +                     ref_list
> +                     "0000"
>    ref_list        =  empty_list / non_empty_list
>  
>    empty_list      =  PKT-LINE(zero-id SP "capabilities^{}" NUL cap-list
> LF)
>  
>    non_empty_list  =  PKT-LINE(obj-id SP name NUL cap_list LF)
> -		     *ref_record
> +                     *ref_record
>  
>    cap-list        =  capability *(SP capability)
>    capability      =  1*(LC_ALPHA / DIGIT / "-" / "_")
> @@ -284,14 +286,15 @@ declarations behind a NUL on the first ref.
>    ref_record      =  any_ref / peeled_ref
>    any_ref         =  PKT-LINE(obj-id SP name LF)
>    peeled_ref      =  PKT-LINE(obj-id SP name LF)
> -		     PKT-LINE(obj-id SP name "^{}" LF
> +                     PKT-LINE(obj-id SP name "^{}" LF
> +
>  
>  Smart Service git-upload-pack
>  ------------------------------
> -This service reads from the repository pointed to by $GIT_URL.
> +This service reads from the repository pointed to by `$GIT_URL`.
>  
>  Clients MUST first perform ref discovery with
> -'$GIT_URL/info/refs?service=git-upload-pack'.
> +`$GIT_URL/info/refs?service=git-upload-pack`.
>  
>     C: POST $GIT_URL/git-upload-pack HTTP/1.0
>     C: Content-Type: application/x-git-upload-pack-request
> @@ -313,18 +316,18 @@ to prevent caching of the response.
>  
>  Servers SHOULD support all capabilities defined here.
>  
> -Clients MUST send at least one 'want' command in the request body.
> -Clients MUST NOT reference an id in a 'want' command which did not
> +Clients MUST send at least one "want" command in the request body.
> +Clients MUST NOT reference an id in a "want" command which did not
>  appear in the response obtained through ref discovery unless the
> -server advertises capability "allow-tip-sha1-in-want".
> +server advertises capability `allow-tip-sha1-in-want`.
>  
>    compute_request   =  want_list
> -		       have_list
> -		       request_end
> +                       have_list
> +                       request_end
>    request_end       =  "0000" / "done"
>  
>    want_list         =  PKT-LINE(want NUL cap_list LF)
> -		       *(want_pkt)
> +                       *(want_pkt)
>    want_pkt          =  PKT-LINE(want LF)
>    want              =  "want" SP id
>    cap_list          =  *(SP capability) SP
> @@ -337,24 +340,28 @@ TODO: Don't use uppercase for variable names below.
>  The Negotiation Algorithm
>  ~~~~~~~~~~~~~~~~~~~~~~~~~
>  The computation to select the minimal pack proceeds as follows
> -(c = client, s = server):
> +(C = client, S = server):
> +
> +'init step:'
> +
> +C: Use ref discovery to obtain the advertised refs.
> +
> +C: Place any object seen into set ADVERTISED.
>  
> - init step:
> - (c) Use ref discovery to obtain the advertised refs.
> - (c) Place any object seen into set ADVERTISED.
> +C: Build an empty set, COMMON, to hold the objects that are later
> +   determined to be on both ends.
>  
> - (c) Build an empty set, COMMON, to hold the objects that are later
> -     determined to be on both ends.
> - (c) Build a set, WANT, of the objects from ADVERTISED the client
> -     wants to fetch, based on what it saw during ref discovery.
> +C: Build a set, WANT, of the objects from ADVERTISED the client
> +   wants to fetch, based on what it saw during ref discovery.
>  
> - (c) Start a queue, C_PENDING, ordered by commit time (popping newest
> -     first).  Add all client refs.  When a commit is popped from
> -     the queue its parents SHOULD be automatically inserted back.
> -     Commits MUST only enter the queue once.
> +C: Start a queue, C_PENDING, ordered by commit time (popping newest
> +   first).  Add all client refs.  When a commit is popped from
> +   the queue its parents SHOULD be automatically inserted back.
> +   Commits MUST only enter the queue once.
>  
> - one compute step:
> - (c) Send one $GIT_URL/git-upload-pack request:
> +'one compute step:'
> +
> +C: Send one `$GIT_URL/git-upload-pack` request:
>  
>     C: 0032want <WANT #1>...............................
>     C: 0032want <WANT #2>...............................
> @@ -367,93 +374,90 @@ The computation to select the minimal pack proceeds as
> follows
>     ....
>     C: 0000
>  
> -     The stream is organized into "commands", with each command
> -     appearing by itself in a pkt-line.  Within a command line
> -     the text leading up to the first space is the command name,
> -     and the remainder of the line to the first LF is the value.
> -     Command lines are terminated with an LF as the last byte of
> -     the pkt-line value.
> +The stream is organized into "commands", with each command
> +appearing by itself in a pkt-line.  Within a command line
> +the text leading up to the first space is the command name,
> +and the remainder of the line to the first LF is the value.
> +Command lines are terminated with an LF as the last byte of
> +the pkt-line value.
>  
> -     Commands MUST appear in the following order, if they appear
> -     at all in the request stream:
> +Commands MUST appear in the following order, if they appear
> +at all in the request stream:
>  
> -       * want
> -       * have
> +* "want"
> +* "have"
>  
> -     The stream is terminated by a pkt-line flush ("0000").
> +The stream is terminated by a pkt-line flush (`0000`).
>  
> -     A single "want" or "have" command MUST have one hex formatted
> -     SHA-1 as its value.  Multiple SHA-1s MUST be sent by sending
> -     multiple commands.
> +A single "want" or "have" command MUST have one hex formatted
> +SHA-1 as its value.  Multiple SHA-1s MUST be sent by sending
> +multiple commands.
>  
> -     The HAVE list is created by popping the first 32 commits
> -     from C_PENDING.  Less can be supplied if C_PENDING empties.
> +The HAVE list is created by popping the first 32 commits
> +from C_PENDING.  Less can be supplied if C_PENDING empties.
>  
> -     If the client has sent 256 HAVE commits and has not yet
> -     received one of those back from S_COMMON, or the client has
> -     emptied C_PENDING it SHOULD include a "done" command to let
> -     the server know it won't proceed:
> +If the client has sent 256 HAVE commits and has not yet
> +received one of those back from S_COMMON, or the client has
> +emptied C_PENDING it SHOULD include a "done" command to let
> +the server know it won't proceed:
>  
>     C: 0009done
>  
> -  (s) Parse the git-upload-pack request:
> -
> -      Verify all objects in WANT are directly reachable from refs.
> -
> -      The server MAY walk backwards through history or through
> -      the reflog to permit slightly stale requests.
> +S: Parse the git-upload-pack request:
>  
> -      If no WANT objects are received, send an error:
> +Verify all objects in WANT are directly reachable from refs.
>  
> -TODO: Define error if no want lines are requested.
> +The server MAY walk backwards through history or through
> +the reflog to permit slightly stale requests.
>  
> -      If any WANT object is not reachable, send an error:
> +If no WANT objects are received, send an error:
> +TODO: Define error if no "want" lines are requested.
>  
> -TODO: Define error if an invalid want is requested.
> +If any WANT object is not reachable, send an error:
> +TODO: Define error if an invalid "want" is requested.
>  
> -     Create an empty list, S_COMMON.
> +Create an empty list, S_COMMON.
>  
> -     If 'have' was sent:
> +If "have" was sent:
>  
> -     Loop through the objects in the order supplied by the client.
> -     For each object, if the server has the object reachable from
> -     a ref, add it to S_COMMON.  If a commit is added to S_COMMON,
> -     do not add any ancestors, even if they also appear in HAVE.
> +Loop through the objects in the order supplied by the client.
>  
> -  (s) Send the git-upload-pack response:
> +For each object, if the server has the object reachable from
> +a ref, add it to S_COMMON.  If a commit is added to S_COMMON,
> +do not add any ancestors, even if they also appear in HAVE.
>  
> -     If the server has found a closed set of objects to pack or the
> -     request ends with "done", it replies with the pack.
> +S: Send the git-upload-pack response:
>  
> +If the server has found a closed set of objects to pack or the
> +request ends with "done", it replies with the pack.
>  TODO: Document the pack based response
> -   S: PACK...
>  
> -     The returned stream is the side-band-64k protocol supported
> -     by the git-upload-pack service, and the pack is embedded into
> -     stream 1.  Progress messages from the server side MAY appear
> -     in stream 2.
> +   S: PACK...
>  
> -     Here a "closed set of objects" is defined to have at least
> -     one path from every WANT to at least one COMMON object.
> +The returned stream is the side-band-64k protocol supported
> +by the git-upload-pack service, and the pack is embedded into
> +stream 1.  Progress messages from the server side MAY appear
> +in stream 2.
>  
> -     If the server needs more information, it replies with a
> -     status continue response:
> +Here a "closed set of objects" is defined to have at least
> +one path from every WANT to at least one COMMON object.
>  
> +If the server needs more information, it replies with a
> +status continue response:
>  TODO: Document the non-pack response
>  
> -  (c) Parse the upload-pack response:
> -
> -TODO: Document parsing response
> +C: Parse the upload-pack response:
> +   TODO: Document parsing response
>  
> -      Do another compute step.
> +'Do another compute step.'
>  
>  
>  Smart Service git-receive-pack
>  ------------------------------
> -This service reads from the repository pointed to by $GIT_URL.
> +This service reads from the repository pointed to by `$GIT_URL`.
>  
>  Clients MUST first perform ref discovery with
> -'$GIT_URL/info/refs?service=git-receive-pack'.
> +`$GIT_URL/info/refs?service=git-receive-pack`.
>  
>     C: POST $GIT_URL/git-receive-pack HTTP/1.0
>     C: Content-Type: application/x-git-receive-pack-request
> @@ -479,10 +483,10 @@ Within the command portion of the request body clients
> SHOULD send
>  the id obtained through ref discovery as old_id.
>  
>    update_request  =  command_list
> -		     "PACK" <binary data>
> +                     "PACK" <binary data>
>  
>    command_list    =  PKT-LINE(command NUL cap_list LF)
> -		     *(command_pkt)
> +                     *(command_pkt)
>    command_pkt     =  PKT-LINE(command LF)
>    cap_list        =  *(SP capability) SP
>  
> -- 
> 1.8.5.2.msysgit.0
> 
> 
> 
> ---
> Thomas
> 

---
Thomas
